from fastapi import FastAPI, File, UploadFile, HTTPException, Response
from pymongo import MongoClient
from pydantic import BaseModel
from bson import ObjectId

app = FastAPI(title="MusicAPI using FastAPI")
conn = MongoClient("mongodb://localhost:27017")
import gridfs



# Setup MongoDB client
conn = MongoClient('mongodb://localhost:27017/')
db = conn['image_db']
fs = gridfs.GridFS(db)

@app.post("/upload/")
async def upload_image(file: UploadFile = File(...)):
    try:
        contents = await file.read()
        file_id = fs.put(contents, filename=file.filename)
        return {"file_id": str(file_id), "filename": file.filename}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")
    


@app.get("/image/{file_id}")
async def get_image(file_id: str):
    try:
        # Convert the file_id from string to ObjectId
        object_id = ObjectId(file_id)
        # Retrieve the file from GridFS
        grid_out = fs.get(object_id)
        # Create a Response object with the file's content and appropriate content type
        return Response(content=grid_out.read(), media_type="image/jpeg")  # Adjust media_type based on file type
    except gridfs.errors.NoFile:
        raise HTTPException(status_code=404, detail="File not found")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")


@app.get("/all-images")
async def get_all_images():
    try:
        files = []
        for file in fs.find():
            files.append({
                "file_id": str(file._id),
                "filename": file.filename,
                "content_type": file.content_type
            })

        return {"images": files}
        # return [{"file_id": str(file._id),"filename": file.filename,"content_type": file.content_type} for file in fs.find()];
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")

db2 = conn["singer_db_test"]
fs2 = gridfs.GridFS(db2)
@app.post("/upload-singer-data")
async def upload_singer_data(name : str,age :str,file: UploadFile = File(...)):
    try:
        contents2 = await file.read()
        return {"file_id":str(fs2.put(contents2,singrname= name,singerage= age))}
        pass
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")
#error    
@app.get("get-singer-data/{file_id}")
def get_ginger_data(file_id : str):
    try:
        return [{"file_id": str(item._id),"singrname":item.singrname} for item in fs2.find({"file_id":file_id})]
    except Exception as e:
         raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")


@app.get("/user")
def get_All_user_data():
    return [{"_id":str(item["_id"]),"name":item["name"],"password":item["password"]}for item in conn.music.user.find()]

#don't touch this code
@app.get("/{id}/{password}")
def get_one_user(id : str,password : str):
    code =[{"_id":str(item["_id"]),"name":item["name"],"password":item["password"]}for item in conn.music.user.find({"name":id ,"password":password })]
    if(code == []):
       raise HTTPException(400,"User doesn't exits")
    return code

#don't touch this code
class User(BaseModel):
    name : str
    password : str

#don't touch this code
@app.post("/user",status_code=201)
def update_data(user : User):
    code =[{"_id":str(item["_id"]),"name":item["name"],"password":item["password"]}for item in conn.music.user.find({"name":user.name,"password":user.password})]
    if(code != []):
        raise HTTPException(400,"Password or name already exits")
    conn.music.user.insert_one(dict(user))
    return {"DATA":"Success"}

#don't touch this code
@app.get("/singer")
def get_all_singer_details():
    return [{"id":str(item["_id"]),"Singer_Name":item["Singer_Name"],"Picture_Location":item["Picture_Location"]} for item in conn.music.singer.find()]

