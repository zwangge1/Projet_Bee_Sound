function similaire = myjudge(c)
    result = find(c>15);
    if ~isempty(result)
        similaire=1; 
    elseif isempty(result)
        similaire=0;
    end
end