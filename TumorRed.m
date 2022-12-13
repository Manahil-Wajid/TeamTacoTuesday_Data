function [SkullStripImage, Distance] = TumorRed(TestImage, Counter, Data)

    TrainingImages = imageDatastore('Final Project Images\Training\', 'IncludeSubfolders', true);
    TestingImages = imageDatastore('Final Project Images\Testingg\', 'IncludeSubfolders', true);
    
    level = graythresh(TestImage);
    I = im2bw(TestImage, level+0.175);
    if Data == 0
        Name = TrainingImages.Files(Counter);
        Name = Name{1};
        Name = Name(129:140);
        Name = extractBefore(Name, '_');
    else
        Name = TestingImages.Files(Counter);
        Name = Name{1};
        Name = Name(129:140);
        Name = extractBefore(Name, '_');
    end
    FileName = [Name, '.mat'];
    load(FileName);
    TumorMask = cjdata.tumorMask;
    TumorPoints = find(I ~= TumorMask);
    [i, j] = find(TumorMask == 1);
    MiddlePoint = round(length(i)/2);
    Distance = round(sqrt((i(MiddlePoint)-1)^2+(j(MiddlePoint)-1)^2));
    I(TumorPoints) = 1;
    
    BinaryImage = bwareaopen(I, 10);
    BinaryImage(end,:) = true;
    BinaryImage = imfill(BinaryImage, 'holes');
    se = strel('disk', 10, 0);
    BinaryImage = imerode(BinaryImage, se);
    SkullStripImage = I;
    SkullStripImage(~BinaryImage) = 0;
end
