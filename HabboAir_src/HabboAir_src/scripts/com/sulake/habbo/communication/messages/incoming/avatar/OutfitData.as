package com.sulake.habbo.communication.messages.incoming.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class OutfitData
   {
      private var _slotId:int;
      
      private var _figureString:String;
      
      private var _gender:String;
      
      public function OutfitData(param1:IMessageDataWrapper, param2:int = 0, param3:String = "", param4:String = "")
      {
         super();
         if(param1 == null)
         {
            _slotId = param2;
            _figureString = param3;
            _gender = param4;
            return;
         }
         _slotId = param1.readInteger();
         _figureString = param1.readString();
         _gender = param1.readString();
      }
      
      public function get slotId() : int
      {
         return _slotId;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
   }
}

