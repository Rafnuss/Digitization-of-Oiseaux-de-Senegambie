% Match GBIF species list

if false
    sp_list = readtable("data/species_list.csv", 'TextType', 'string');

    sp_list.kingdom(:) = "animalia";
    sp_list.phylum(:) = "chordata";
    sp_list.class(:) = "aves";
    sp_list.order(:) = "";
    sp_list.family(:)	= "";
    sp_list.genus(:) = "";
    sp_list.species(:) = "";
    sp_list.taxonRank(:) = "species";
    sp_list.scientificName(:) = "";
    sp_list.canonicalName(:) = "";
    sp_list.matchType(:) = "";
    sp_list.species(:) = "";
    sp_list.key(:)="";
    
    % first pass with scientific name
    for i_sp=1:height(sp_list)
        try
            if ismissing(sp_list.corrected_name(i_sp))
                name = sp_list.original_name(i_sp);
            else
                name = sp_list.corrected_name(i_sp);
            end
            res = webread("https://api.gbif.org/v1/species/match?name="+name);
            sp_list.order(i_sp) = res.order;
            sp_list.family(i_sp)	= res.family;
            sp_list.genus(i_sp) = res.genus;
            sp_list.scientificName(i_sp) = res.scientificName;
            sp_list.matchType(i_sp) = res.matchType;
            sp_list.species(i_sp) = res.species;
            sp_list.canonicalName(i_sp) = res.canonicalName;
            sp_list.key(i_sp) = res.speciesKey;
        end
    end
    writetable(sp_list,'data/gbif/sp_list_gbif.xlsx')
else
    % Read file
    sp_list = readtable('data/gbif/sp_list_gbif.xlsx','TextType', 'string');
end




%%  Constructure table
grid = readtable('data/geometry/grid.csv', 'TextType', 'string');

presence = readtable("data/presence.csv", 'TextType', 'string', "ReadVariableNames",true);
presence_file = presence{:,1};
presence = presence{:,2:end};
dots = readtable("data/dots.csv", 'TextType', 'string');

assert(all(dots.name==grid.name))

[file_id, map_id]=find(presence);

data = table(map_id, file_id, VariableNames=["map_id", "file_id"]);

% drop pelagic map
data=data(data.map_id~=1,:);

%% 

% define eventDate
data.eventDateLabel(:) = "1970/1984";
data.eventDate(:) = "1970-01-01T00:00:00/1984-01-01T00:00:00";


% Basic static information
data.basisOfRecord(:) = "Occurrence";
% data.reproductiveConditionProperty = data.atlas;
% data.occurrenceRemarks(:) = data.atlas;
data.occurrenceStatus(:) = "present";

% Taxonomy
data.kingdom(:) = "animalia";
data.phylum(:) = "chordata";
data.class(:) = "aves";
data.taxonRank(:) = "species";
data.family(:) = "";
data.genus(:) = "";
data.order(:) = "";
data.scientificName(:) = "";
data.originalNameUsage(:) ="";
data.taxonID(:)="";

for i_sp=1:height(sp_list)
    tmp = find(presence_file==sp_list.map(i_sp));
    if numel(tmp)~=1
        disp(tmp)
        continue
    end

    id = data.file_id == tmp;
    
    data.taxonID(id) = sp_list.key(i_sp);
    data.originalNameUsage(id) = sp_list.original_name(i_sp);
    data.order(id) = sp_list.order(i_sp);
    data.family(id)	= sp_list.family(i_sp);
    data.genus(id) = sp_list.genus(i_sp);
    data.scientificName(id) = sp_list.scientificName(i_sp);
    data.taxonRemarks(id) = "map N°"+sp_list.map_index(i_sp);
end

% Geography
data.continent(:) = "Africa";
% data.countryCode(:) = "KE";
data.country = dots.country(data.map_id);

data.footprintWKT = grid.geometry(data.map_id);
data.footprintSRS(:) = "epsg:4326";

data.decimalLatitude= dots.lat(data.map_id);
data.decimalLongitude = dots.lon(data.map_id); 
data.geodeticDatum(:) = "epsg:4326";

data.locality = dots.name(data.map_id);
% Add occurence id
data.occurrenceID = "species_"+data.taxonID+"|"+data.locality;
%data.occurrenceID = data.eventDateLabel +"_"+data.CommonName+"_"+data.SqN+"_"+data.SqL;
data=sortrows(data,'occurrenceID');

% return duplicate
[U,I] = unique(data.occurrenceID,'first');
x = 1:height(data); x(I)=[];

% data(ismember(data.occurrenceID, data.occurrenceID(x)),:)
assert(numel(data.occurrenceID)==numel(unique(data.occurrenceID)))



%% 
writetable(removevars(data,["map_id","taxonID", "file_id"]),"data/gbif/occurrence.csv")