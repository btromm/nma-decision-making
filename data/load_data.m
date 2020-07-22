%% Load data

% load data
if ~exist('vect','var')
  load data/np_vector.mat
end

% Choose your fighter (brain region you want to look at)
temp = vect{1};
reg = temp.brain_area;

for i = 1:length(reg)
    list_regions_(i) = convertCharsToStrings(reg(i,:));
end
list_regions = [""];
for i = 1:length(list_regions)
  if ~ismember(list_regions,list_regions_(i))
    if length(list_regions) == 0
      list_regions(1) = list_regions_(i);
    else
      list_regions(end) = list_regions_(i);
    end
  end
end
list_regions
prompt = 'Choose your region (enter with " "):'
region = input(prompt)



% pull out all data blocks for selected region
counter = 1;
for n = 1:size(vect,2)
    dat = vect{n};
    spikes = dat.spks;
    brain_regions = dat.brain_area;
    responses = dat.response;

    for i = 1:length(brain_regions)
        B(i) = convertCharsToStrings(brain_regions(i,:));
    end

    region_spikes = [];
    region_idx = find(B == region);

    if ~isempty(region_idx)
        region_spikes = spikes(region_idx,:,:);
        responses = dat.response;
        contrast_left = dat.contrast_left;
        contrast_right = dat.contrast_right;
        D_dat = [];
        for i = 1:size(spikes,2)
            D_dat(i).data = squeeze(region_spikes(:,i,:));
            D_dat(i).condition = num2str(responses(i));
            D_dat(i).contrast_left = num2str(contrast_left(i));
            D_dat(i).contrast_right = num2str(contrast_right(i));
        end
        all_region{counter,1} = D_dat;
        counter = counter + 1;
    end
    clear region_idx;
    clear B;
end
