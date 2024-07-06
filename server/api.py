from fastapi import FastAPI
from pymongo import MongoClient
from pydantic import BaseModel
from bson import ObjectId

app = FastAPI(title="Music App")
conn = MongoClient("mongodb+srv://user_01:Ni1234Ni@cluster0.iewfpw3.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0/musicapp")

@app.get("/user")
def get_All_user_data():
    return [{"_id":str(item["_id"]),"name":item["name"],"password":item["password"]}for item in conn.musicapp.user.find()]

@app.get("/{name}")
def get_user_data(name : str):
    return [{"_id":str(item["_id"]),"name":item["name"],"password":item["password"]} for item in conn.musicapp.user.find({"name":name})]

class User(BaseModel):
    name : str
    password :str

@app.post("/")
def post_one_user_data(user : User):
    conn.musicapp.user.insert_one(dict(user))
    return {"Data":"Success"}

@app.delete("/delete/{name}")
def delete_one_user_data(name : str):
    conn.musicapp.user.find_one_and_delete({"name":name})
    return {"Data":"Success"}
    
    