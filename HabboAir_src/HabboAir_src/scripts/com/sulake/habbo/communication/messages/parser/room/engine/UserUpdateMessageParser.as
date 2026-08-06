package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.AvatarActionMessageData;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageData;
   
   [SecureSWF(rename="true")]
   public class UserUpdateMessageParser implements IMessageParser
   {
      private var _users:Array = [];
      
      public function UserUpdateMessageParser()
      {
         super();
      }
      
      public function get userUpdateCount() : int
      {
         return _users.length;
      }
      
      public function flush() : Boolean
      {
         _users = [];
         return true;
      }
      
      public function getUserUpdateData(param1:int) : UserUpdateMessageData
      {
         if(param1 < 0 || param1 >= userUpdateCount)
         {
            return null;
         }
         return _users[param1];
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc23_:int = 0;
         var _loc16_:int = 0;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc14_:* = NaN;
         var _loc3_:int = 0;
         var _loc26_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:String = null;
         var _loc11_:* = false;
         var _loc17_:int = 0;
         var _loc8_:int = 0;
         var _loc31_:Array = null;
         var _loc21_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:Array = null;
         var _loc9_:Boolean = false;
         var _loc24_:int = 0;
         var _loc6_:String = null;
         var _loc15_:Array = null;
         var _loc27_:String = null;
         var _loc18_:String = null;
         var _loc4_:Array = null;
         var _loc25_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:UserUpdateMessageData = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc22_:int = param1.readInteger();
         _loc23_ = 0;
         while(_loc23_ < _loc22_)
         {
            _loc16_ = param1.readInteger();
            _loc28_ = param1.readInteger();
            _loc29_ = param1.readInteger();
            _loc30_ = Number(param1.readString());
            _loc14_ = 0;
            _loc3_ = param1.readInteger();
            _loc26_ = param1.readInteger();
            _loc2_ = param1.readInteger();
            _loc10_ = param1.readString();
            _loc11_ = false;
            _loc17_ = _loc3_ % 8 * 45;
            _loc8_ = _loc26_ % 8 * 45;
            _loc31_ = [];
            _loc21_ = 0;
            _loc20_ = 0;
            _loc19_ = 0;
            _loc12_ = false;
            _loc13_ = _loc10_.split("/");
            _loc9_ = false;
            _loc24_ = 0;
            while(_loc24_ < _loc13_.length)
            {
               _loc6_ = _loc13_[_loc24_] as String;
               _loc15_ = _loc6_.split(" ");
               _loc27_ = String(_loc15_[0]);
               _loc18_ = "";
               if(_loc27_ != "")
               {
                  if(_loc27_ == "wf")
                  {
                     _loc9_ = true;
                  }
                  if(_loc15_.length >= 2)
                  {
                     _loc18_ = String(_loc15_[1]);
                     switch(_loc27_)
                     {
                        case "mv":
                           _loc4_ = _loc18_.split(",");
                           if(_loc4_.length >= 3)
                           {
                              _loc21_ = int(_loc4_[0]);
                              _loc20_ = int(_loc4_[1]);
                              _loc19_ = Number(_loc4_[2]);
                              _loc12_ = true;
                           }
                           break;
                        case "sit":
                           _loc25_ = Number(_loc18_);
                           if(_loc15_.length >= 3)
                           {
                              _loc11_ = _loc15_[2] == "1";
                           }
                           _loc14_ = _loc25_;
                           break;
                        case "lay":
                           _loc7_ = Number(_loc18_);
                           if(_loc7_ < 0)
                           {
                           }
                           _loc14_ = Math.abs(_loc7_);
                     }
                  }
                  _loc31_.push(new AvatarActionMessageData(_loc27_,_loc18_));
               }
               _loc24_++;
            }
            _loc5_ = new UserUpdateMessageData(_loc16_,_loc28_,_loc29_,_loc30_,_loc14_,_loc8_,_loc17_,_loc21_,_loc20_,_loc19_,_loc12_,_loc11_,_loc31_,_loc9_,_loc2_);
            _users.push(_loc5_);
            _loc23_++;
         }
         return true;
      }
   }
}

