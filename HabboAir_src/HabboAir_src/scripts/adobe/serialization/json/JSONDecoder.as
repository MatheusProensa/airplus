package adobe.serialization.json
{
   public class JSONDecoder
   {
      private var UnknownVarFromJSONDecoder_Boolean_1:Boolean;
      
      private var value:*;
      
      private var UnknownVarFromJSONDecoder_JSONTokenizer_1:JSONTokenizer;
      
      private var token:JSONToken;
      
      public function JSONDecoder(param1:String, param2:Boolean)
      {
         super();
         this.UnknownVarFromJSONDecoder_Boolean_1 = param2;
         UnknownVarFromJSONDecoder_JSONTokenizer_1 = new JSONTokenizer(param1,param2);
         nextToken();
         value = parseValue();
         if(param2 && nextToken() != null)
         {
            UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Unexpected characters left in input stream");
         }
      }
      
      public function getValue() : *
      {
         return value;
      }
      
      final private function nextToken() : JSONToken
      {
         return token = UnknownVarFromJSONDecoder_JSONTokenizer_1.getNextToken();
      }
      
      final private function nextValidToken() : JSONToken
      {
         token = UnknownVarFromJSONDecoder_JSONTokenizer_1.getNextToken();
         checkValidToken();
         return token;
      }
      
      final private function checkValidToken() : void
      {
         if(token == null)
         {
            UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Unexpected end of input");
         }
      }
      
      final private function parseArray() : Array
      {
         var _loc1_:Array = [];
         nextValidToken();
         if(token.type == 4)
         {
            return _loc1_;
         }
         if(!UnknownVarFromJSONDecoder_Boolean_1 && token.type == 0)
         {
            nextValidToken();
            if(token.type == 4)
            {
               return _loc1_;
            }
            UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Leading commas are not supported.  Expecting \']\' but found " + token.value);
         }
         while(true)
         {
            _loc1_.push(parseValue());
            nextValidToken();
            if(token.type == 4)
            {
               break;
            }
            if(token.type == 0)
            {
               nextToken();
               if(!UnknownVarFromJSONDecoder_Boolean_1)
               {
                  checkValidToken();
                  if(token.type == 4)
                  {
                     return _loc1_;
                  }
               }
            }
            else
            {
               UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Expecting ] or , but found " + token.value);
            }
         }
         return _loc1_;
      }
      
      final private function parseObject() : Object
      {
         var _loc1_:String = null;
         var _loc2_:Object = {};
         nextValidToken();
         if(token.type == 2)
         {
            return _loc2_;
         }
         if(!UnknownVarFromJSONDecoder_Boolean_1 && token.type == 0)
         {
            nextValidToken();
            if(token.type == 2)
            {
               return _loc2_;
            }
            UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Leading commas are not supported.  Expecting \'}\' but found " + token.value);
         }
         while(true)
         {
            if(token.type == 10)
            {
               _loc1_ = String(token.value);
               nextValidToken();
               if(token.type == 6)
               {
                  nextToken();
                  _loc2_[_loc1_] = parseValue();
                  nextValidToken();
                  if(token.type == 2)
                  {
                     break;
                  }
                  if(token.type == 0)
                  {
                     nextToken();
                     if(!UnknownVarFromJSONDecoder_Boolean_1)
                     {
                        checkValidToken();
                        if(token.type == 2)
                        {
                           return _loc2_;
                        }
                     }
                  }
                  else
                  {
                     UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Expecting } or , but found " + token.value);
                  }
               }
               else
               {
                  UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Expecting : but found " + token.value);
               }
            }
            else
            {
               UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Expecting string but found " + token.value);
            }
         }
         return _loc2_;
      }
      
      final private function parseValue() : Object
      {
         checkValidToken();
         switch(token.type - 1)
         {
            case 0:
               return parseObject();
            case 2:
               return parseArray();
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
               return token.value;
            case 11:
               if(!UnknownVarFromJSONDecoder_Boolean_1)
               {
                  return token.value;
               }
               UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Unexpected " + token.value);
               break;
         }
         UnknownVarFromJSONDecoder_JSONTokenizer_1.parseError("Unexpected " + token.value);
         return null;
      }
   }
}

