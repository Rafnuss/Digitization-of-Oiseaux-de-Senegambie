% load the grid
% load('data/grid')
% load('data/data_fix')

template_empty = double(imread("data/template/template_empty.png"));
gszt = size(template_empty);
template_full = double(rgb2gray(imread("data/template/template_full.png"))>100);
assert(all(size(template_full)==size(template_empty)))

template_dots = double(rgb2gray(imread("data/template/template_dots.png"))>100);
assert(all(size(template_dots)==size(template_empty)))

[template_dots_labeled, numberOfDots] = bwlabel(~template_dots);

dots_id = find(template_dots_labeled>0);

sum_full = splitapply(@mean,template_full(dots_id), template_dots_labeled(dots_id));
sum_empty = splitapply(@mean,template_empty(dots_id), template_dots_labeled(dots_id));

dots = table();
dots.key = (1:numberOfDots)';
dots.x=nan(numberOfDots,1); dots.y=nan(numberOfDots,1);
for i=1:numberOfDots
    [row, col] = find(template_dots_labeled==i);
    dots.x(i) = mean(col);
    dots.y(i) = mean(row);
end

figure('position',[0 0 900 900]);  tiledlayout('vertical','TileSpacing','none','Padding','none');
nexttile; imagesc(template_empty); colormap(gray); axis equal tight;
nexttile; imagesc(template_full); colormap(gray); axis equal tight;
nexttile; imagesc(template_dots); hold on ;colormap(gray); axis equal tight;
text(dots.x,dots.y-20,string(1:numel(dots.y)), "HorizontalAlignment","center")
scatter(dots.x,dots.y,200,"red", LineWidth=2)

xy_box = [40 397 37 301];
ll_box = [-18 -11 17 12];

dots.lon = interp1(xy_box(1:2), ll_box(1:2),dots.x);
dots.lat = interp1(xy_box(3:4), ll_box(3:4),dots.y);

dots.country(:) = "Senegal";
dots.country([6 9 15 21]) = "Gambia";
dots.country(1) = "Pelagic";

figure; 
% Plot points on a geographic map
geoscatter(dots.lat(dots.country=="Senegal"), dots.lon(dots.country=="Senegal"), 200, [0, 0.6, 0.2], "filled",  'LineWidth', 3);
hold on;
geoscatter(dots.lat(dots.country=="Gambia"), dots.lon(dots.country=="Gambia"), 200, [0, 0.3176, 0.6196], "filled", 'LineWidth', 3);
geoscatter(dots.lat(dots.country=="Pelagic"), dots.lon(dots.country=="Pelagic"), 200, [0.8, 0.8, 0.8], "filled", 'LineWidth', 3);
% Add the map background
geobasemap('landcover'); 
geolimits(ll_box(4:-1:3), ll_box(1:2))

dots.grid = [nan 0 5 4 3 29 2 6 30 9 8 10 7 11 31 16 12 14 15 13 32 21 17 20 19 18 25 24 23 22 27 26]';
%% 

% Find all page to read
flr = dir("data/book/");
flr = flr(contains({flr.name},".png"));
% possible_page_nb = cellfun(@(x) str2double(x(28:end-4)),{flr.name});
% file_base = flr(1).name(1:27);

% Prepare structure of data
n_species=2000;
mapImSp=nan(gszt(1), gszt(2),n_species);
presence = true(numberOfDots,n_species);
pageNbSp = strings(1,n_species);

%%
dots.thr(:) = 0.9*ones(size(dots.y));
dots.thr(6)=0.8;
dots.thr(22)=0.7;
dots.thr(21)=0.8;
dots.thr(27)=0.75;
dots.thr(15)=0.80;

i_sp=0;
for i_f = 31:151  % i_f=31 -> 151;
    fl=flr(i_f);
    disp(fl.name)

    page = imread(fl.folder+"/"+fl.name);
    if size(page,3)==3
        page = rgb2gray(page);
    end
    szp = size(page);

    if false
        figure; imagesc(page); axis equal tight; colormap('gray')
    end

    % Adjust based on resolution if needed
    % Define the scaling factor to upscale between image resolution. For some
    % reason some page have been scan with a different resolution and the
    % template was also at this smaller resolution, so we upscale them all
    % before.
    % fminbnd(@(s) 1-max(normxcorr2(template,imresize(page,s)),[],'all'),.5,1,optimset('TolX',.01,'Display','iter'))
    if false
        scale=2.35;
        page = imresize(page,scale);
        szp = size(page);
    end
    assert(max(page,[],'all')<=1)

    if false
        figure; hold on; imagesc(page); imagesc(template_empty); set(gca,'ydir','reverse'); axis equal tight off; colormap('gray')
    end

    % compute the cross-correlation
    c = normxcorr2(template_empty,page);
    c = c(ceil(gszt(1)/2):(end-floor(gszt(1)/2)),ceil(gszt(2)/2):(end-floor(gszt(2)/2)));
    
    if false
        figure; imagesc(c); axis equal tight;
    end

    % extract the position of the match
    % a threashold of 0.25 is used to find all the maps
    c(c<.25)=nan;
    % Iteratively find all the map on the pages, remove all max value nearby
    id=[];
    while ~all(isnan(c(:)))
        [~,tmp]=max(c(:));
        id = [id;tmp];
        [id_yc,id_xc] = ind2sub(szp,tmp);
        id_y = id_yc-round(gszt(1)/2);
        id_x = id_xc-round(gszt(2)/2);
        c(id_y+(1:gszt(1)),id_x+(1:gszt(2)))=nan;
    end

    % Get the final position of the max
    [id_yc,id_xc] = ind2sub(szp,id);
    id_y = id_yc-round(gszt(1)/2);
    id_x = id_xc-round(gszt(2)/2);
    % sort map by page along the x axis

    [~,id_xysort]=sort(floor(id_y/(szp(1)/3))+floor(id_x/(szp(2)/2.2))*3);
    id_x=id_x(id_xysort);
    id_y=id_y(id_xysort);

    if false
        figure; hold on; imagesc(page); scatter(id_xc,id_yc,'r')
        set(gca,'ydir','reverse'); axis off equal tight; colormap('gray');
    end


    disp([num2str(numel(id)) ' matches'])

    % Loop through the maps
    for i_m=1:numel(id)
        i_sp=i_sp+1;

        % Get the map as image
        mapImSp(:,:,i_sp) = page(id_y(i_m)+(1:gszt(1)),id_x(i_m)+(1:gszt(2)));

        tmp = mapImSp(:,:,i_sp);

        % write the image
        pageNbSp(i_sp) = [fl.name(1:end-4) '_' num2str(i_m)];
        imwrite(tmp,"data/extract/"+pageNbSp(i_sp)+".png")

        % Find the most similar pattern between empty and full
        % err_full = splitapply(@mean,(tmp(dots_id)-template_full(dots_id)).^2, template_dots_labeled(dots_id));
        % err_empty = splitapply(@mean,(tmp(dots_id)-template_empty(dots_id)).^2, template_dots_labeled(dots_id));
        sum_map = splitapply(@mean,tmp(dots_id), template_dots_labeled(dots_id));
        % err_empty = splitapply(@mean,(tmp(dots_id)-template_empty(dots_id)).^2, template_dots_labeled(dots_id));
        
        presence_index = (sum_map - sum_full) ./ (sum_empty - sum_full);
        
        % Determine the presence
        presence(:, i_sp) = presence_index < dots.thr;
       
        if true
            figure('position',[0 0 900 600], Visible='off'); 
            % figure('position',[0 0 900 600]); 
            tiledlayout('vertical','TileSpacing','none','Padding','none');
            nexttile;
            imagesc(tmp); colormap(gray); axis equal tight; hold on; 
            scatter(dots.x(~presence(:,i_sp)), dots.y(~presence(:,i_sp)), 100, [0, 1, 1], LineWidth=2); 
            scatter(dots.x(presence(:,i_sp)), dots.y(presence(:,i_sp)), 100, [1, 0, 1], LineWidth=2);
            nexttile;
            scatter(dots.x, dots.y, 100, presence_index, "filled"); axis equal tight; hold on; 
            text(dots.x,dots.y-20,string(1:numel(dots.y))'+"|"+string(round(presence_index*100)), "HorizontalAlignment","center")
            xlim([0 size(tmp,2)]); ylim([0 size(tmp,1)]); colormap(gca, "parula"); set(gca,"YDir","reverse")
            % keyboard
             exportgraphics(gcf,"data/extract_classify/"+pageNbSp(i_sp)+".png")
        end
    end
end

%% Save

% save("data/presence.mat", presence, dots, pageNbSp)

writetable(table(pageNbSp(1:i_sp)', presence(:,1:i_sp)'),"data/presence.csv")
writetable(dots,"data/dots.csv")