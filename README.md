# Battery logger
Скрипт для логирования состояния батареи во времени. Имеется функция составления графика.

## Зависимости: feh, pnuplot
- Fedora:
```shell
sudo dnf install -y gnuplot feh
```
- Debian, Ubuntu, Mint:
```shell
sudo apt-get install -y gnuplot feh
```
- Arch:
```shell
sudo pacman -Sy gnuplot feh
```

## Использование:
```shell
git clone https://github.com/DenHax/battary-logger.git
```
Запуск планировщика:
```shell
crontab -e
```
В планировщике прописываем запуск скрипта каждые 10 минут (*/10):
```
*/10 * * * * /full/path/to/energy_timer/btr_monitor.sh  >/dev/null 2>&1
```
Для генерации графика без перехода в директорию сделайте алиас на второй скрипт репозитория:
```shell
alias btrplt=/path/to/energy_timer/btr_plot.sh
```
