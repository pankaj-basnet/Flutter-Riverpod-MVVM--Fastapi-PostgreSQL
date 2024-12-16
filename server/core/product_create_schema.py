from pydantic import BaseModel

class ProductCreate(BaseModel):
    # id : str # id not needed  sn=
    title : str
    price : str
    photo_url : str
    description : str

# class ProductRetrieve(BaseModel):
#     # id : str # id not needed  sn=
#     title : str
#     price : str
#     photo_url : str
#     description : str
