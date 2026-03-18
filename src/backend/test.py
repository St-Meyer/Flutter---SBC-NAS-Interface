import psutil

for x in range(3):
    print("CPU PERCENT: " + str(psutil.cpu_percent(interval=1, percpu=True)))

print("KERNE: " + str(psutil.cpu_count()))

print("ECHTE KERNE: " + str(psutil.cpu_count(logical=False)))

print("STATS: " + str(psutil.cpu_stats()))

print("FREQ: " + str(psutil.cpu_freq()))

print("DISC USAGE: " + str(psutil.disk_usage('/')))

print("TEMP: " + str(psutil.sensors_temperatures()))

