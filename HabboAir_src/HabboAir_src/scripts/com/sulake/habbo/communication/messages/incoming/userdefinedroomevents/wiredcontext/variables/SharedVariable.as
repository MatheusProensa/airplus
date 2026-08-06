package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SharedVariable
   {
      private var _wiredVariable:WiredVariable;
      
      private var _roomId:int;
      
      private var _roomName:String;
      
      public function SharedVariable(param1:IMessageDataWrapper)
      {
         super();
         _roomId = param1.readInteger();
         _roomName = param1.readString();
         _wiredVariable = new WiredVariable(param1);
      }
      
      public function get wiredVariable() : WiredVariable
      {
         return _wiredVariable;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
   }
}

