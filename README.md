**Конфигурация NEOVIM для работы с ESP-IDF в windows**  

Инструкция по установки всех компонетов для работы с ESP32 в NEOVIM.  
Плагины в neovim устанавливаем с помощью Lazy.  

**Установка среды ESP-IDF**  
Создаем папку C:\espressif, в нее скачиваем репозиторий ESP-IDF:  
```  
git clone https://github.com/espressif/esp-idf
```  
переходим в папку репозитория:  
```  
cd C:\espressif\esp-idf
```  
Выполняем команду установки среды:  
```  
install.bat
```  
Для того что бы развернуть рабочую среду IDF в этом терминале надо выполнить:  
```  
export.bat
```  
Чтобы мы эту команду выполняли где угодно надо добавить ее в системный PATH:  
```  
C:\espressif\esp-idf
```  

**Установка clang от ESP-IDF**  
Инструкция на сайде IDF - https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-guides/tools/idf-clang-tidy.html  
Перейдите в каталог:  
```  
cd C:\espressif\esp-idf\tools
```  
Выполините команду:
```  
python idf_tools.py install esp-clang
```  
После этого надо запустить export.bat что бы обновить переменные среды  

**Установка NEOVIM**  
Инструкция на сайте - https://github.com/neovim/neovim/blob/master/INSTALL.md  
Установка через chocolatey -    
Устанавливаем с начало chocolatey:  
Инструкция на сайте - https://docs.chocolatey.org/en-us/choco/setup/  
Установите .NET Framework 4.8  
Запускаем PowerShell от имени администратора  
```  
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```  

После этого можно установить neovim  
```  
choco install neovim
```  
Путь установки надо добавить в PATCH, если его там нет- C:\tools\neovim\nvim-win64\bin  
По этому пути будем запускать nvim.exe  

**Конфигурация neovim**  
Переходим по этому пути:  
```
C:\Users\Admin\AppData\Local\
```
Там создаем папку nvim  
В результате получаем путь - C:\Users\Admin\AppData\Local\nvim  
в эту папку нам надо скопировать содержимое репозитория. В итоге получаем содержимое папки:  

C:\Users\Admin\AppData\Local\nvim:  
autoload  
lazy  
lua - тут находяться все плагини неовим  
init.lua - главный файл настроик неовим  
lazy-lock.json  

**Как работать с этой средой**  
Подсветка синтаксиса и автодополнения будет работать в соответствии с ESP-IDF  

SPC клавиша (спец клавиша) в neovim настроенна как пробел (space)  
Открыть терминал ESP-IDF:    space + t + e  
Свернуть терминвл ESP-IDF:   space + t + h  
Развернуть терминал ESP-IDF: space + t + s  

Закомментировать/раскомментировать выделенный текст: g + c






