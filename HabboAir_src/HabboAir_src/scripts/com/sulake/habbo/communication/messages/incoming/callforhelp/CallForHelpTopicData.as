package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.moderation.IRoomData;
   
   [SecureSWF(rename="true")]
   public class CallForHelpTopicData implements IRoomData
   {
      private var _name:String;
      
      private var _id:int;
      
      private var _consequence:String;
      
      public function CallForHelpTopicData(param1:IMessageDataWrapper)
      {
         super();
         _name = param1.readString();
         _id = param1.readInteger();
         _consequence = param1.readString();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get consequence() : String
      {
         return _consequence;
      }
   }
}

