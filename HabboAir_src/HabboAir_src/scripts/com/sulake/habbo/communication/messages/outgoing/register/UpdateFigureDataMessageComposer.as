package com.sulake.habbo.communication.messages.outgoing.register
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UpdateFigureDataMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function UpdateFigureDataMessageComposer(param1:String, param2:String)
      {
         super();
         _messageArray.push(param2);
         _messageArray.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
   }
}

