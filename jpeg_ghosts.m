function diffImages = jpeg_ghosts(file, b, minQ, maxQ, stepQ)
    
    % read the image and convert to double precision
    image = im2double(imread(file));

    % Pre-allocate the output array
    numImages = numel(minQ:stepQ:maxQ);
    diffImages = cell(1, numImages);

    % from minQ to maxQ iterating stepQ units at a time
    for i = minQ:stepQ:maxQ
        % Compress and decompress the image with lossy quality i
        imwrite(image, 'foundJPEG.jpg', 'Mode', 'lossy', 'Quality', i);
        jpegImage = im2double(imread('foundJPEG.jpg'));

        % Define the rows and columns
        [rows, cols, ~] = size(image);

        % Pre-allocate the current image.  Has less columns and rows
        % becasue of cells in the final row and column don't have enough
        % pixels to perform the mean and normalisation.
        diff_image = zeros(rows-b+1, cols-b+1);

        % Iterate over the rows and columns of the image
        for row = 1:rows-b+1
            for col = 1:cols-b+1
                % Get the bxb block for the original and compressed image
                original_block = image(row:row+b-1, col:col+b-1, :);
                jpeg_block = jpegImage(row:row+b-1, col:col+b-1, :);

                % Find the mean for each RGB layer
                diff_block_R = double(original_block(:,:,1)) - double(jpeg_block(:,:,1));
                diff_block_G = double(original_block(:,:,2)) - double(jpeg_block(:,:,2));
                diff_block_B = double(original_block(:,:,3)) - double(jpeg_block(:,:,3));

                % Sum the squared differences across the RGB components
                diff_sum = diff_block_R.^2 + diff_block_G.^2 + diff_block_B.^2;
                diff_sum = sum(sum(diff_sum));
                diff_image(row, col) = 1/3 * 1/(b^2) * diff_sum;
            end
        end
        
        % Perform normalization
        norm_diff_image = (diff_image - min(diff_image(:))) / (max(diff_image(:)) - min(diff_image(:)));

        % Extra steps here use imadJust and histeq to increase the contrast
        % of the image to make the JPEG ghost easier to see.  These lines
        % aren't neccesairy just make the result clearer.

        norm_diff_image_histeq = histeq(norm_diff_image);
        
        diff_image_adjust = imadjust(norm_diff_image_histeq);
        
        % Add the normalized image to the return array
        diffImages{i} = norm_diff_image;
    end
end
