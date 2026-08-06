package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class BadgePartData
   {
      private var _id:int;
      
      private var _fileName:String;
      
      private var _maskFileName:String;
      
      public function BadgePartData(param1:IMessageDataWrapper = null)
      {
         super();
         _id = param1.readInteger();
         _fileName = param1.readString();
         _maskFileName = param1.readString();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get fileName() : String
      {
         return _fileName;
      }
      
      public function get maskFileName() : String
      {
         return _maskFileName;
      }
   }
}

