function [trInput,trDes,tsInput,tsDes,dim,n_class] = Data_create(num_train,num_test)

trI = loadMNISTImages('train-images.idx3-ubyte');
trD = loadMNISTLabels('train-labels.idx1-ubyte');
tsI = loadMNISTImages('t10k-images.idx3-ubyte');  
tsD = loadMNISTLabels('t10k-labels.idx1-ubyte');
dim = 10;
n_class = 10;

trInput = zeros(28, 28, 1, num_train);
trDes = zeros(num_train, 1);
for ii = 1:num_train
    trInput(:,:,1,ii) = trI(:,:,ii);
    trDes(ii,1) = trD(ii,1);
end

tsInput = zeros(28, 28, 1, num_test);
tsDes = zeros(num_test, 1);
for ii = 1:num_test
    tsInput(:,:,1,ii) = tsI(:,:,ii);
    tsDes(ii,1) = tsD(ii,1);
end


end
