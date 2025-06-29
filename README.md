# Project Descriptions

## English:
**Coverage Analysis Automation Tool** - Python script that automates code coverage testing workflow. Runs pytest with coverage, generates comprehensive reports in TXT, Markdown, and HTML formats with timestamps. Perfect for CI/CD integration and development monitoring.

## Russian:
**Инструмент автоматизации анализа покрытия кода** - Python скрипт для автоматизации тестирования покрытия. Запускает pytest с coverage, создает подробные отчеты в форматах TXT, Markdown и HTML с временными метками. Идеален для CI/CD и мониторинга разработки.

# Coverage Analysis Automation Tool

**Инструмент автоматизации анализа покрытия кода** - Python скрипт для автоматизации тестирования покрытия кода с генерацией подробных отчетов в различных форматах.

## 🎯 Описание

Этот проект представляет собой автоматизированный инструмент для анализа покрытия кода Python проектов. Скрипт запускает полный цикл тестирования с измерением покрытия и создает структурированные отчеты в нескольких форматах для удобного анализа и мониторинга качества кода.

## ✨ Возможности

- 🔍 **Автоматический запуск тестов** с измерением покрытия кода
- 📊 **Генерация отчетов** в трех форматах:
  - 📄 Текстовый отчет (.txt)
  - 📝 Markdown отчет (.md) 
  - 🌐 Интерактивный HTML отчет
- ⏰ **Временные метки** для отслеживания изменений
- 📁 **Организованное хранение** отчетов в отдельной папке
- 🎨 **Цветной вывод** в консоли для лучшего восприятия
- 🔧 **Обработка ошибок** с подробным логированием

## 📋 Требования

- Python 3.6+
- pytest
- coverage
- pathlib (входит в стандартную библиотеку)

## 🚀 Установка

```bash
# Клонировать репозиторий
git clone <repository-url>
cd coverage-analysis-tool

# Установить зависимости
pip install -r requirements.txt
```

## 📦 Содержимое requirements.txt

```
pytest>=6.0.0
coverage>=5.0.0
```

## 🔧 Использование

### Базовое использование

```bash
python script.py
```

### Структура проекта

```
project/
├── calculator.py          # Основной код проекта
├── test_calculator.py     # Тесты
├── script.py             # Скрипт анализа покрытия
├── requirements.txt      # Зависимости
├── coverage_reports/     # Папка с отчетами
│   ├── coverage_report_YYYYMMDD_HHMMSS.txt
│   └── coverage_report_YYYYMMDD_HHMMSS.md
└── htmlcov/             # HTML отчеты
    └── index.html
```

## 📊 Выполняемые команды

Скрипт автоматически выполняет следующие команды:

1. `coverage run -m pytest` - Запуск тестов с измерением покрытия
2. `coverage report -m` - Генерация текстового отчета с указанием пропущенных строк
3. `coverage html` - Создание интерактивного HTML отчета

## 📈 Форматы отчетов

### Текстовый отчет (.txt)
- Подробная информация о выполнении каждой команды
- Статистика покрытия
- Список пропущенных строк
- Временные метки и метаданные

### Markdown отчет (.md)
- Структурированный отчет с заголовками
- Форматированный код и вывод
- Эмодзи для статусов выполнения
- Удобен для документации и GitHub

### HTML отчет
- Интерактивный веб-интерфейс
- Подсветка синтаксиса
- Навигация по файлам
- Детальная информация о покрытии каждой строки

## 🛠️ Настройка

### Пример файла .coveragerc

```ini
# .coveragerc
[run]
source = .
omit = 
    */venv/*
    */env/*
    */tests/*
    setup.py

[report]
exclude_lines =
    pragma: no cover
    def __repr__
    raise AssertionError
    raise NotImplementedError
```

## 📝 Примеры использования

### Для CI/CD pipeline

```yaml
# .github/workflows/coverage.yml
name: Coverage Analysis
on: [push, pull_request]
jobs:
  coverage:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.8
    - name: Install dependencies
      run: pip install -r requirements.txt
    - name: Run coverage analysis
      run: python script.py
    - name: Upload coverage reports
      uses: actions/upload-artifact@v2
      with:
        name: coverage-reports
        path: coverage_reports/
```

### Интеграция с pre-commit

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: coverage-check
        name: Coverage Analysis
        entry: python script.py
        language: system
        pass_filenames: false
```

## 🎯 Особенности

- **Автоматическое создание папок** для организации отчетов
- **Обработка ошибок** с сохранением в отчеты
- **Кроссплатформенность** (Windows, macOS, Linux)
- **Минимальные зависимости** для легкой интеграции
- **Подробное логирование** всех операций

## 🔍 Мониторинг качества

Скрипт помогает отслеживать:
- Процент покрытия кода тестами
- Непротестированные участки кода
- Динамику изменения покрытия во времени
- Результаты выполнения тестов

## 🤝 Вклад в проект

1. Форкните репозиторий
2. Создайте ветку для новой функциональности
3. Внесите изменения
4. Добавьте тесты
5. Создайте Pull Request

## 📄 Лицензия

MIT License - подробности в файле LICENSE

## 🆘 Поддержка

Если у вас возникли вопросы или проблемы:
- Создайте Issue в GitHub
- Проверьте существующие Issues на похожие проблемы
- Убедитесь, что все зависимости установлены корректно

## 📊 Статистика проекта

- **Языки:** Python
- **Тестирование:** pytest
- **Покрытие:** coverage.py
- **Совместимость:** Python 3.6+

---

*Этот инструмент создан для упрощения процесса анализа покрытия кода и улучшения качества разработки.*
