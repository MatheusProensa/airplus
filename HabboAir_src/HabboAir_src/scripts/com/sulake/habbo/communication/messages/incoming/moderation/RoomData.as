package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RoomData implements IComponentInterfaceQueue
   {
      private var _exists:Boolean;
      
      private var _name:String;
      
      private var _desc:String;
      
      private var _tags:Array;
      
      private var _disposed:Boolean;
      
      public function RoomData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _tags = [];
         super();
         _exists = param1.readBoolean();
         if(!exists)
         {
            return;
         }
         _name = param1.readString();
         _desc = param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _tags.push(param1.readString());
            _loc3_++;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _tags = null;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function get tags() : Array
      {
         return _tags;
      }
      
      public function get exists() : Boolean
      {
         return _exists;
      }
   }
}

