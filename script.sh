#!/usr/bin/env python3
"""
Скрипт для запуска coverage анализа и сохранения отчетов в разных форматах.
"""

import subprocess
import os
import datetime
from pathlib import Path

def run_command(cmd, description):
    """Выполняет команду и возвращает результат."""
    print(f"Выполняется: {description}")
    print(f"Команда: {cmd}")
    
    try:
        result = subprocess.run(
            cmd, 
            shell=True, 
            capture_output=True, 
            text=True, 
            check=True
        )
        return result.stdout, result.stderr, True
    except subprocess.CalledProcessError as e:
        return e.stdout, e.stderr, False

def save_report(content, filename, format_type="txt"):
    """Сохраняет отчет в файл."""
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    
    if format_type == "md":
        full_filename = f"coverage_report_{timestamp}.md"
    else:
        full_filename = f"coverage_report_{timestamp}.txt"
    
    try:
        with open(full_filename, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"✓ Отчет сохранен: {full_filename}")
        return full_filename
    except Exception as e:
        print(f"✗ Ошибка при сохранении {full_filename}: {e}")
        return None

def main():
    """Основная функция скрипта."""
    print("=== Coverage Report Generator ===")
    print(f"Время запуска: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print()
    
    # Создаем папку для отчетов если её нет
    reports_dir = Path("coverage_reports")
    reports_dir.mkdir(exist_ok=True)
    os.chdir(reports_dir)
    
    # Возвращаемся в родительскую директорию для выполнения команд
    os.chdir("..")
    
    # Команды для выполнения
    commands = [
        ("coverage run -m pytest", "Запуск тестов с coverage"),
        ("coverage report -m", "Генерация текстового отчета"),
        ("coverage html", "Генерация HTML отчета")
    ]
    
    # Для сохранения всех результатов
    all_results = []
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # Заголовок для отчетов
    txt_report = f"COVERAGE ANALYSIS REPORT\n"
    txt_report += f"Дата и время: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
    txt_report += f"Рабочая директория: {os.getcwd()}\n"
    txt_report += "=" * 80 + "\n\n"
    
    md_report = f"# Coverage Analysis Report\n\n"
    md_report += f"**Дата и время:** {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}  \n"
    md_report += f"**Рабочая директория:** `{os.getcwd()}`\n\n"
    md_report += "---\n\n"
    
    for cmd, description in commands:
        print(f"\n{'='*60}")
        stdout, stderr, success = run_command(cmd, description)
        
        # Формируем результат для текстового отчета
        txt_section = f"{description.upper()}\n"
        txt_section += f"Команда: {cmd}\n"
        txt_section += f"Статус: {'✓ Успешно' if success else '✗ Ошибка'}\n"
        txt_section += "-" * 40 + "\n"
        
        if stdout:
            txt_section += "ВЫВОД:\n" + stdout + "\n"
        
        if stderr:
            txt_section += "ОШИБКИ:\n" + stderr + "\n"
        
        txt_section += "\n" + "=" * 60 + "\n\n"
        txt_report += txt_section
        
        # Формируем результат для Markdown отчета
        md_section = f"## {description}\n\n"
        md_section += f"**Команда:** `{cmd}`  \n"
        md_section += f"**Статус:** {'✅ Успешно' if success else '❌ Ошибка'}\n\n"
        
        if stdout:
            md_section += "### Вывод:\n```\n" + stdout + "\n```\n\n"
        
        if stderr:
            md_section += "### Ошибки:\n```\n" + stderr + "\n```\n\n"
        
        md_section += "---\n\n"
        md_report += md_section
        
        # Выводим результат в консоль
        if success:
            print("✓ Команда выполнена успешно")
            if stdout:
                print("Вывод:")
                print(stdout)
        else:
            print("✗ Ошибка при выполнении команды")
            if stderr:
                print("Ошибки:")
                print(stderr)
    
    # Сохраняем отчеты
    print(f"\n{'='*60}")
    print("Сохранение отчетов...")
    
    # Переходим в папку для отчетов
    os.chdir("coverage_reports")
    
    # Сохраняем текстовый отчет
    txt_filename = save_report(txt_report, f"coverage_report_{timestamp}", "txt")
    
    # Сохраняем Markdown отчет
    md_filename = save_report(md_report, f"coverage_report_{timestamp}", "md")
    
    # Информация о HTML отчете
    html_dir = "../htmlcov"
    if os.path.exists(html_dir):
        print(f"✓ HTML отчет создан в директории: {os.path.abspath(html_dir)}")
        print(f"  Откройте файл: {os.path.abspath(html_dir)}/index.html")
    else:
        print("✗ HTML отчет не найден")
    
    print(f"\n{'='*60}")
    print("ГОТОВО!")
    print(f"Текстовый отчет: {os.path.abspath(txt_filename) if txt_filename else 'не создан'}")
    print(f"Markdown отчет: {os.path.abspath(md_filename) if md_filename else 'не создан'}")
    print(f"HTML отчет: {os.path.abspath(html_dir) if os.path.exists(html_dir) else 'не создан'}")

if __name__ == "__main__":
    main()
