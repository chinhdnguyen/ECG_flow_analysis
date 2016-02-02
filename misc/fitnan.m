function [C keep1 keep2] = fitnan(array1,array2, order)

validdata1 = ~isnan(array1);
validdata2 = ~isnan(array2);
validdataBoth = validdata1 & validdata2;
keep1 = array1(validdataBoth);
keep2 = array2(validdataBoth);

C = polyfit(keep1, keep2, order);