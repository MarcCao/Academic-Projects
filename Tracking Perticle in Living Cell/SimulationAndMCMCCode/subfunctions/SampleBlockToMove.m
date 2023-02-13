function Blocks = SampleBlockToMove(N,options)
% Randomly split sequence of length N into blocks


%sample block size (same even for multiple blocks)
BlockSize=randi([options.MinBlockSize options.MaxBlockSize]);

if isfield(options,'MultipleBlocks') && options.MultipleBlocks
    BlockStarts=(1:BlockSize:(N-1));
    BlockEnds=BlockStarts+BlockSize;
    BlockEnds(BlockEnds>N)=N;
    Blocks=[BlockStarts' BlockEnds'];
else
    %sample the first timepoint in the block
    BlockStart=randi([1 N-BlockSize]);
    
    Blocks=BlockStart:BlockStart+BlockSize-1;
end


end