function [MaximumArea, AverageDensity] = TumorDat(SkullStripImage)
    Label = bwlabel(SkullStripImage);
    Description = regionprops(Label, 'Solidity', 'Area');
    Area = [Description.Area];
    Density = [Description.Solidity];
    AverageDensity = mean(Density);
    HighestDensity = Density > mad(Density)-0.5;
    MaximumArea = max(Area(HighestDensity));
    TumorLabel = find(Area == MaximumArea);
    Tumor = ismember(Label, TumorLabel);
end