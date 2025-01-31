# Задание

> Нужно:
> 1. Использовать gem ActiveInteraction => https://github.com/AaronLasseigne/active_interaction отрефакторить класс Users::Create 
> 2. Исправить опечатку Skil. Есть 2 пути решения. Описать оба.
> 3. Исправить связи
> 4. Поднять Rails приложение и в нем использовать класс Users::Create
> 5. Написать тесты
> 6. При рефакторнге кода использовать Декларативное описание(подход в программировании)

# Заметки

## Как исправить опечатку Skil

Я использовал средства IDE. CTRL+Shift+H, затем можно провести замену всех слов с опечаткой:

```
Skil(?=[^l]) заменить на Skill
skil(?=[^l]) заменить на skill
```

Либо через bash:
```
find . -type f -name "*.rb" -exec sed -i '' 's/Skil(?=[^l])/Skill/g' {} +
find . -type f -name "*.rb" -exec sed -i '' 's/skil(?=[^l])/skill/g' {} +
```
