%% EE152 Lab2 - Jack Maynard jmayn001@ucr.edu
%%
clear; clc; close all;

fence =  imread('fence.jpg');
clouds = imread('clouds.jpg');

%% Part 1a
fence_128A  = imresize(fence,  [128 128], 'Antialiasing', true); 
fence_128   = imresize(fence,  [128 128], 'Antialiasing', false);
clouds_128A = imresize(clouds, [128 128], 'Antialiasing', true);
clouds_128  = imresize(clouds, [128 128], 'Antialiasing', false);

subplot(1,2,1); imshow(fence_128A);  title('Fence with antialiasing'); 
subplot(1,2,2); imshow(fence_128);   title('Fence wihtout antialiasing');  figure;
subplot(1,2,1); imshow(clouds_128A); title('Clouds with antialiasing');
subplot(1,2,2); imshow(clouds_128);  title('Clouds without antialiasing'); figure;
%%
% The images without antialiasing have some sharp edges that were not
% visible in the original picture. The images with antialiasing look
% blurrier but do not have any false details.
%% Part 1b
fence_512AN  = imresize(fence_128A, [512 512], 'nearest');
fence_512ABL = imresize(fence_128A, [512 512], 'bilinear');
fence_512ABC = imresize(fence_128A, [512 512], 'bicubic');
fence_512N   = imresize(fence_128,  [512 512], 'nearest');
fence_512BL  = imresize(fence_128,  [512 512], 'bilinear');
fence_512BC  = imresize(fence_128,  [512 512], 'bicubic');

clouds_512AN  = imresize(clouds_128A, [512 512], 'nearest');
clouds_512ABL = imresize(clouds_128A, [512 512], 'bilinear');
clouds_512ABC = imresize(clouds_128A, [512 512], 'bicubic');
clouds_512N   = imresize(clouds_128,  [512 512], 'nearest');
clouds_512BL  = imresize(clouds_128,  [512 512], 'bilinear');
clouds_512BC  = imresize(clouds_128,  [512 512], 'bicubic');

subplot(2,3,1); imshow(fence_512AN);  title('Nearest + AA');
subplot(2,3,2); imshow(fence_512ABL); title('Bilinear + AA');
subplot(2,3,3); imshow(fence_512ABC); title('Bicubic+ AA');
subplot(2,3,4); imshow(fence_512N);   title('Nearest');
subplot(2,3,5); imshow(fence_512BL);  title('Bilinear');
subplot(2,3,6); imshow(fence_512BC);  title('Bicubic'); figure;
subplot(2,3,1); imshow(clouds_512AN);  title('Nearest + AA');
subplot(2,3,2); imshow(clouds_512ABL); title('Bilinear + AA');
subplot(2,3,3); imshow(clouds_512ABC); title('Bicubic+ AA');
subplot(2,3,4); imshow(clouds_512N);   title('Nearest');
subplot(2,3,5); imshow(clouds_512BL);  title('Bilinear');
subplot(2,3,6); imshow(clouds_512BC);  title('Bicubic');
%%
% Nearest interpolation appears blocky, while bilinear and bicubic appear
% much smoother.

%% Part 2a
i = 256;
while i > 1
    quant = floor(fence_128 / (256/i)) * (256/(i - 1));
    subplot(2,4,9-log2(i)); imshow(quant); title(strcat(num2str(log2(i)), ' bits '));
    i = i/2;
end
figure;

i = 256;
while i > 1
    quant = floor(clouds_128 / (256/i)) * (256/(i - 1));
    subplot(2,4,9-log2(i)); imshow(quant); title(strcat(num2str(log2(i)), ' bits '));
    i = i/2;
end
figure;
%% Part 2b
% False contouring appears at 5 bit quantization

%% Part 2c
% Next we quantized our images with random noise added
fence_noise = fence_128 + uint8(randi([0 64], [128 128 3]));
i = 256;
while i > 1
    quant = floor(fence_noise / (256/i)) * (256/(i - 1));
    subplot(2,4,9-log2(i)); imshow(quant); title(strcat(num2str(log2(i)), ' bits '));
    i = i/2;
end
figure;

clouds_noise = clouds_128 + uint8(randi([0 128], [128 128 3]));
i = 256;
while i > 1
    quant = floor(clouds_128 / (256/i)) * (256/(i - 1));
    subplot(2,4,9-log2(i)); imshow(quant); title(strcat(num2str(log2(i)), ' bits '));
    i = i/2;
end
figure;

%% Part 3a
hood     = imread('hood.jpg');
no_hood  = imread('no_hood.jpg');

%% Part 3b
diff_hood  = no_hood - hood;

%% Part 3c
thresh_pic = diff_hood;
thresh_pic = mean(thresh_pic,3);
threshold = 50;
thresh_pic(thresh_pic <= threshold) = 0;
%Must set to 0 first, otherwise values set to 1 are below threshold and
%are then set to 0
thresh_pic(thresh_pic > threshold) = 1;
imshow(thresh_pic);
%%
% Raising the threshold higher eliminates some of the dark spots on my face
% but also creates light spots on the background. The swwet spot is a
% threshold of 50.
    
    

