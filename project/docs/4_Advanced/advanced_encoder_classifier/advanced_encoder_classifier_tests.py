import hashlib
from hashlib import sha256

def hash(data):
    h=hashlib.new("SHA256")
    h.update(data.encode())
    return h.hexdigest()

class Tests():
    
    def test1(answer):
        if str(hash(answer)) == "df7e70e5021544f4834bbee64a9e3789febc4be81470df629cad6ddb03320a5c":
            return print ("Correct!")
        
        else:
            return print("Incorrect, see the introduction part to find what the strengths of encoder classification are.")    
        
    def test2(answer):
        if str(hash(answer)) == "6b23c0d5f35d1b11f9b683f0b0a617355deb11277d91ae091d399c655b87940d":
            return print ("Correct!")
        
        elif str(hash(answer)) == "df7e70e5021544f4834bbee64a9e3789febc4be81470df629cad6ddb03320a5c":
            return print("Incorrect, recall the description in the question. Is there a way for us to make better use of the given pattern? ")    
        
        else:
            return print("Incorrect, revisit the concept and consider what is the strategy that can cope with large amounts of labels? ")