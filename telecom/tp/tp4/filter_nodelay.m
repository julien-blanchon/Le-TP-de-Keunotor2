function y = filter_nodelay(h, a, x)
%FILTER_NODELAY filter + suppr delay
order = sum(h~=0);
delay = floor((order-1)/2)-1;
y_zeropadding = filter(h, 1, [x zeros(1, delay)]);
y = y_zeropadding(delay+1:end);
end