package adobe.serialization.json
{
   public class JSONTokenizer
   {
      private var UnknownVarFromJSONTokenizer_Boolean_1:Boolean;
      
      private var UnknownVarFromJSONTokenizer_Object_1:Object;
      
      private var jsonString:String;
      
      private var loc:int;
      
      private var ch:String;
      
      private const UnknownConstFromJSONTokenizer_RegExp_1:RegExp = /[\x00-\x1F]/;
      
      public function JSONTokenizer(param1:String, param2:Boolean)
      {
         super();
         jsonString = param1;
         this.UnknownVarFromJSONTokenizer_Boolean_1 = param2;
         loc = 0;
         nextChar();
      }
      
      public function getNextToken() : JSONToken
      {
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc4_:JSONToken = null;
         skipIgnored();
         switch(ch)
         {
            case "{":
               _loc4_ = JSONToken.create(1,ch);
               nextChar();
               break;
            case "}":
               _loc4_ = JSONToken.create(2,ch);
               nextChar();
               break;
            case "[":
               _loc4_ = JSONToken.create(3,ch);
               nextChar();
               break;
            case "]":
               _loc4_ = JSONToken.create(4,ch);
               nextChar();
               break;
            case ",":
               _loc4_ = JSONToken.create(0,ch);
               nextChar();
               break;
            case ":":
               _loc4_ = JSONToken.create(6,ch);
               nextChar();
               break;
            case "t":
               _loc1_ = "t" + nextChar() + nextChar() + nextChar();
               if(_loc1_ == "true")
               {
                  _loc4_ = JSONToken.create(7,true);
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'true\' but found " + _loc1_);
               }
               break;
            case "f":
               _loc3_ = "f" + nextChar() + nextChar() + nextChar() + nextChar();
               if(_loc3_ == "false")
               {
                  _loc4_ = JSONToken.create(8,false);
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'false\' but found " + _loc3_);
               }
               break;
            case "n":
               _loc2_ = "n" + nextChar() + nextChar() + nextChar();
               if(_loc2_ == "null")
               {
                  _loc4_ = JSONToken.create(9,null);
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'null\' but found " + _loc2_);
               }
               break;
            case "N":
               _loc5_ = "N" + nextChar() + nextChar();
               if(_loc5_ == "NaN")
               {
                  _loc4_ = JSONToken.create(12,NaN);
                  nextChar();
               }
               else
               {
                  parseError("Expecting \'NaN\' but found " + _loc5_);
               }
               break;
            case "\"":
               _loc4_ = readString();
               break;
            default:
               if(isDigit(ch) || ch == "-")
               {
                  _loc4_ = readNumber();
               }
               else if(ch == "")
               {
                  _loc4_ = null;
               }
               else
               {
                  parseError("Unexpected " + ch + " encountered");
               }
         }
         return _loc4_;
      }
      
      final private function readString() : JSONToken
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = loc;
         while(true)
         {
            _loc3_ = int(jsonString.indexOf("\"",_loc3_));
            if(_loc3_ >= 0)
            {
               _loc2_ = 0;
               _loc1_ = _loc3_ - 1;
               while(jsonString.charAt(_loc1_) == "\\")
               {
                  _loc2_++;
                  _loc1_--;
               }
               if((_loc2_ & 1) == 0)
               {
                  break;
               }
               _loc3_++;
            }
            else
            {
               parseError("Unterminated string literal");
            }
         }
         var _loc4_:JSONToken = JSONToken.create(10,unescapeString(jsonString.substr(loc,_loc3_ - loc)));
         loc = _loc3_ + 1;
         nextChar();
         return _loc4_;
      }
      
      public function unescapeString(param1:String) : String
      {
         var _loc8_:String = null;
         var _loc6_:String = null;
         var _loc4_:int = 0;
         var _loc7_:* = 0;
         var _loc5_:String = null;
         if(UnknownVarFromJSONTokenizer_Boolean_1 && Boolean(UnknownConstFromJSONTokenizer_RegExp_1.test(param1)))
         {
            parseError("String contains unescaped control character (0x00-0x1F)");
         }
         var _loc2_:String = "";
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc3_:int = param1.length;
         do
         {
            _loc9_ = int(param1.indexOf("\\",_loc10_));
            if(_loc9_ < 0)
            {
               _loc2_ += param1.substr(_loc10_);
               break;
            }
            _loc2_ += param1.substr(_loc10_,_loc9_ - _loc10_);
            _loc10_ = _loc9_ + 2;
            switch(_loc8_ = param1.charAt(_loc9_ + 1))
            {
               case "\"":
                  _loc2_ += _loc8_;
                  break;
               case "\\":
                  _loc2_ += _loc8_;
                  break;
               case "n":
                  _loc2_ += "\n";
                  break;
               case "r":
                  _loc2_ += "\r";
                  break;
               case "t":
                  _loc2_ += "\t";
                  break;
               case "u":
                  _loc6_ = "";
                  _loc4_ = _loc10_ + 4;
                  if(_loc4_ > _loc3_)
                  {
                     parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                  }
                  _loc7_ = _loc10_;
                  while(_loc7_ < _loc4_)
                  {
                     _loc5_ = param1.charAt(_loc7_);
                     if(!isHexDigit(_loc5_))
                     {
                        parseError("Excepted a hex digit, but found: " + _loc5_);
                     }
                     _loc6_ += _loc5_;
                     _loc7_++;
                  }
                  _loc2_ += String.fromCharCode(parseInt(_loc6_,16));
                  _loc10_ = _loc4_;
                  break;
               case "f":
                  _loc2_ += "\f";
                  break;
               case "/":
                  _loc2_ += "/";
                  break;
               case "b":
                  _loc2_ += "\b";
                  break;
               default:
                  _loc2_ += "\\" + _loc8_;
            }
         }
         while(_loc10_ < _loc3_);
         
         return _loc2_;
      }
      
      final private function readNumber() : JSONToken
      {
         var _loc1_:String = "";
         if(ch == "-")
         {
            _loc1_ += "-";
            nextChar();
         }
         if(!isDigit(ch))
         {
            parseError("Expecting a digit");
         }
         if(ch == "0")
         {
            _loc1_ += ch;
            nextChar();
            if(isDigit(ch))
            {
               parseError("A digit cannot immediately follow 0");
            }
            else if(!UnknownVarFromJSONTokenizer_Boolean_1 && ch == "x")
            {
               _loc1_ += ch;
               nextChar();
               if(isHexDigit(ch))
               {
                  _loc1_ += ch;
                  nextChar();
               }
               else
               {
                  parseError("Number in hex format require at least one hex digit after \"0x\"");
               }
               while(isHexDigit(ch))
               {
                  _loc1_ += ch;
                  nextChar();
               }
            }
         }
         else
         {
            while(isDigit(ch))
            {
               _loc1_ += ch;
               nextChar();
            }
         }
         if(ch == ".")
         {
            _loc1_ += ".";
            nextChar();
            if(!isDigit(ch))
            {
               parseError("Expecting a digit");
            }
            while(isDigit(ch))
            {
               _loc1_ += ch;
               nextChar();
            }
         }
         if(ch == "e" || ch == "E")
         {
            _loc1_ += "e";
            nextChar();
            if(ch == "+" || ch == "-")
            {
               _loc1_ += ch;
               nextChar();
            }
            if(!isDigit(ch))
            {
               parseError("Scientific notation number needs exponent value");
            }
            while(isDigit(ch))
            {
               _loc1_ += ch;
               nextChar();
            }
         }
         var _loc2_:Number = Number(_loc1_);
         if(isFinite(_loc2_) && !isNaN(_loc2_))
         {
            return JSONToken.create(11,_loc2_);
         }
         parseError("Number " + _loc2_ + " is not valid!");
         return null;
      }
      
      final private function nextChar() : String
      {
         return ch = jsonString.charAt(loc++);
      }
      
      final private function skipIgnored() : void
      {
         var _loc1_:int = 0;
         do
         {
            _loc1_ = loc;
            skipWhite();
            skipComments();
         }
         while(_loc1_ != loc);
         
      }
      
      private function skipComments() : void
      {
         if(ch == "/")
         {
            nextChar();
            switch(ch)
            {
               case "/":
                  do
                  {
                     nextChar();
                  }
                  while(ch != "\n" && ch != "");
                  
                  nextChar();
                  break;
               case "*":
                  nextChar();
                  while(true)
                  {
                     if(ch == "*")
                     {
                        nextChar();
                        if(ch == "/")
                        {
                           break;
                        }
                     }
                     else
                     {
                        nextChar();
                     }
                     if(ch == "")
                     {
                        parseError("Multi-line comment not closed");
                     }
                  }
                  nextChar();
                  break;
               default:
                  parseError("Unexpected " + ch + " encountered (expecting \'/\' or \'*\' )");
            }
         }
      }
      
      final private function skipWhite() : void
      {
         while(isWhiteSpace(ch))
         {
            nextChar();
         }
      }
      
      final private function isWhiteSpace(param1:String) : Boolean
      {
         if(param1 == " " || param1 == "\t" || param1 == "\n" || param1 == "\r")
         {
            return true;
         }
         if(!UnknownVarFromJSONTokenizer_Boolean_1 && param1.charCodeAt(0) == 160)
         {
            return true;
         }
         return false;
      }
      
      final private function isDigit(param1:String) : Boolean
      {
         return param1 >= "0" && param1 <= "9";
      }
      
      final private function isHexDigit(param1:String) : Boolean
      {
         return isDigit(param1) || param1 >= "A" && param1 <= "F" || param1 >= "a" && param1 <= "f";
      }
      
      final public function parseError(param1:String) : void
      {
         throw new JSONParseError(param1,loc,jsonString);
      }
   }
}

