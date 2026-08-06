package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomInviteErrorMessageParser implements IMessageParser
   {
      private var _errorCode:int;
      
      private var UnknownVarFromRoomInviteErrorMessageParser_Array_1:Array;
      
      public function RoomInviteErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.UnknownVarFromRoomInviteErrorMessageParser_Array_1 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this._errorCode = param1.readInteger();
         if(this._errorCode == 1)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.UnknownVarFromRoomInviteErrorMessageParser_Array_1.push(param1.readInteger());
               _loc3_++;
            }
         }
         return true;
      }
      
      public function get errorCode() : int
      {
         return this._errorCode;
      }
      
      public function get failedRecipients() : Array
      {
         return this.UnknownVarFromRoomInviteErrorMessageParser_Array_1;
      }
   }
}

