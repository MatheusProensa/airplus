package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetYoutubeDisplayPlaylistMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function SetYoutubeDisplayPlaylistMessageComposer(param1:int, param2:String)
      {
         super();
         _messageArray = [param1,param2];
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

