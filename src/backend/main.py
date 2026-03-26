from fastapi import FastAPI
import psutil

app = FastAPI()

@app.get("/status")
async def status():
    return {"CPU AUSLASTUNG:": str(psutil.cpu_percent(interval=1, percpu=True))}