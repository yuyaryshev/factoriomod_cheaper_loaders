-- Fetch the reduction factor from settings
local cost_reduction_factor = settings.startup["cheaper_loaders_cost_reduction_factor"].value

-- Loop through all recipes
for name, recipe in pairs(data.raw.recipe) do
    -- Check if the recipe name ends with "-loader"
    if string.match(name, "-loader$") then
		-- recipe.energy_required = recipe.energy_required / cost_reduction_factor
        -- Loop through all ingredients in the recipe
        if recipe.ingredients then
            for _, ingredient in pairs(recipe.ingredients) do
                if ingredient.amount and ingredient.amount > 10 then
                    -- Reduce the ingredient count by the reduction factor
                    ingredient.amount = math.ceil(ingredient.amount / cost_reduction_factor)
                end
            end
        end
        -- Handle cases where ingredients are stored in a different format (e.g., within "normal" and "expensive" variants)
        if recipe.normal and recipe.normal.ingredients then
            for _, ingredient in pairs(recipe.normal.ingredients) do
                if ingredient.amount and ingredient.amount > 10 then
                    ingredient.amount = math.ceil(ingredient.amount / cost_reduction_factor)
                end
            end
        end
        if recipe.expensive and recipe.expensive.ingredients then
            for _, ingredient in pairs(recipe.expensive.ingredients) do
                if ingredient.amount and ingredient.amount > 10 then
                    ingredient.amount = math.ceil(ingredient.amount / cost_reduction_factor)
                end
            end
        end
    end
end
