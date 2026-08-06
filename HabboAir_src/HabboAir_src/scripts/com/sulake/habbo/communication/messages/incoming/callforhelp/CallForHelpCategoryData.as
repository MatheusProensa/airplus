package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.moderation.IRoomData;
   
   [SecureSWF(rename="true")]
   public class CallForHelpCategoryData implements IRoomData, IComponentInterfaceQueue
   {
      private var _name:String;
      
      private var _topics:Vector.<CallForHelpTopicData>;
      
      private var _disposed:Boolean;
      
      public function CallForHelpCategoryData(param1:IMessageDataWrapper)
      {
         var _loc2_:int = 0;
         super();
         _topics = new Vector.<CallForHelpTopicData>();
         _name = param1.readString();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _topics.push(new CallForHelpTopicData(param1));
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _topics = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get topics() : Vector.<CallForHelpTopicData>
      {
         return _topics;
      }
   }
}

