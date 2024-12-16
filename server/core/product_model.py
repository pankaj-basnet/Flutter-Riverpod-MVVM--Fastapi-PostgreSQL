from pydantic import BaseModel
from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy import *       # import specific library if possible # comment this sn=
from sqlalchemy import Column, TEXT, VARCHAR, create_engine

# from sqlalchemy.orm import *     # import specific library if possible # comment this sn=
from sqlalchemy.orm import sessionmaker

Base = declarative_base()

class Product(Base):
    __tablename__ = 'products'

    id = Column(TEXT, primary_key=True)
    title = Column(TEXT)
    price = Column(VARCHAR(6)) # change to integer later sn=
    photo_url = Column(TEXT)
    description = Column(VARCHAR(100))



# class Product(Base):
#     title: str
#     description: str
#     price: int
#     photo_url: str
    

#   ========    Database    ========
DATABASE_URL = 'postgresql://postgres:Mansion199@localhost:5432/refashionapp'

engine = create_engine(DATABASE_URL)

#   -----    docs   -----
# class Session:
    # def __init__(
    #     self, 
    #     autoflush: bool = True,
    #     binds: Optional[Dict[_SessionBindKey, _SessionBind]] = None,
    #     autocommit: Literal[False] = False,

SessionLocal = sessionmaker(autocommit = False, autoflush= False, bind=engine )

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

