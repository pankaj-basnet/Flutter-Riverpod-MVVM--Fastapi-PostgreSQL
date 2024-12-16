# from fastapi import * # import specific library if possible # comment this sn=

from fastapi import APIRouter, Depends, HTTPException

# from product_model import * 
from core.product_model import get_db, Product

# from sqlalchemy.orm import * 
from sqlalchemy.orm import Session 

# from product_create_schema import * 
from core.product_create_schema import ProductCreate

import uuid

router = APIRouter()



# middleware for product or other endpoints


@router.post('/create', status_code=201)
def create_product(product: ProductCreate , db: Session=Depends(get_db)):

    # check if product already exists
    product_db = db.query(Product).filter(Product.title == product.title).first()

    if product_db:
        raise HTTPException(400, "Product with the same title already exists!") 

    # add product to the db
    product_db = Product(id=str(uuid.uuid4()), title = product.title, price = product.price, photo_url = product.photo_url, description = product.description)

    db.add(product_db)
    db.commit()
    db.refresh(product_db)



@router.get('/', status_code=200)
def get_product(db: Session=Depends(get_db)):

    products = db.query(Product).all()
    
    return products
     