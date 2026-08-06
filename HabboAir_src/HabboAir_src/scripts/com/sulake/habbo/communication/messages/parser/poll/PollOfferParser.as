package com.sulake.habbo.communication.messages.parser.poll
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PollOfferParser implements IMessageParser
   {
      private var _id:int = -1;
      
      private var _type:String = "";
      
      private var _headline:String = "";
      
      private var _summary:String = "";
      
      public function PollOfferParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get headline() : String
      {
         return _headline;
      }
      
      public function get summary() : String
      {
         return _summary;
      }
      
      public function flush() : Boolean
      {
         _id = -1;
         _type = "";
         _summary = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _id = param1.readInteger();
         _type = param1.readString();
         _headline = param1.readString();
         _summary = param1.readString();
         return true;
      }
   }
}

