from fastapi import FastAPI, Request
from core import product_route

from pydantic import * # import specific library if possible # comment this sn=

from core.product_model import Base, engine

# router


app = FastAPI()


#   ======  fastapi docs  ======
# def include_router(
#     router: APIRouter,
#     *,
#     prefix: str = "",

app.include_router(product_route.router, prefix="/product")

Base.metadata.create_all(engine)

 