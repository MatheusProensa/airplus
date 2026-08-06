package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredTransactionInfo
   {
      public static var UnknownVarFromWiredTransactionInfo_Int_1:int = 0;
      
      public static var UnknownVarFromWiredTransactionInfo_Int_2:int = 1;
      
      public static var UnknownVarFromWiredTransactionInfo_Int_3:int = 2;
      
      public static var UnknownVarFromWiredTransactionInfo_Int_4:int = 3;
      
      public static var UnknownVarFromWiredTransactionInfo_Int_5:int = 4;
      
      private var _transactionId:Number;
      
      private var _flatId:int;
      
      private var _transactionType:int;
      
      private var _transactionDefinitionInfo:String;
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var _timestamp:Number;
      
      private var _readableTimestamp:String;
      
      private var _chestCount:int;
      
      private var _withdrawFurniCount:int;
      
      private var _depositFurniCount:int;
      
      private var _withdrawCoinsCount:int;
      
      private var _depositCoinsCount:int;
      
      public function WiredTransactionInfo(param1:IMessageDataWrapper)
      {
         super();
         _transactionId = param1.readLong();
         _flatId = param1.readInteger();
         _transactionType = param1.readInteger();
         _transactionDefinitionInfo = param1.readString();
         _userId = param1.readInteger();
         _userName = param1.readString();
         _timestamp = param1.readLong();
         _readableTimestamp = param1.readString();
         _chestCount = param1.readInteger();
         _withdrawFurniCount = param1.readInteger();
         _depositFurniCount = param1.readInteger();
         _withdrawCoinsCount = param1.readInteger();
         _depositCoinsCount = param1.readInteger();
      }
      
      public function get transactionId() : Number
      {
         return _transactionId;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get transactionType() : int
      {
         return _transactionType;
      }
      
      public function get transactionDefinitionInfo() : String
      {
         return _transactionDefinitionInfo;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get timestamp() : Number
      {
         return _timestamp;
      }
      
      public function get readableTimestamp() : String
      {
         return _readableTimestamp;
      }
      
      public function get chestCount() : int
      {
         return _chestCount;
      }
      
      public function get withdrawFurniCount() : int
      {
         return _withdrawFurniCount;
      }
      
      public function get depositFurniCount() : int
      {
         return _depositFurniCount;
      }
      
      public function get withdrawCoinsCount() : int
      {
         return _withdrawCoinsCount;
      }
      
      public function get depositCoinsCount() : int
      {
         return _depositCoinsCount;
      }
   }
}

