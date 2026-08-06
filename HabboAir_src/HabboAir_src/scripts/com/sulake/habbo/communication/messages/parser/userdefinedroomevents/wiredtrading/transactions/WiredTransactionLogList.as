package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionLogList implements IComponentInterfaceQueue
   {
      public static var UnknownVarFromWiredTransactionLogList_Int_1:int = 0;
      
      public static var UnknownVarFromWiredTransactionLogList_Int_2:int = 1;
      
      private var _logListType:int;
      
      private var _logListId:Number;
      
      private var _totalLogs:int;
      
      private var _currentPage:int;
      
      private var _amount:int;
      
      private var _logs:Vector.<WiredTransactionInfo>;
      
      private var _disposed:Boolean;
      
      public function WiredTransactionLogList(param1:IMessageDataWrapper)
      {
         var _loc2_:int = 0;
         super();
         _logListType = param1.readInteger();
         _logListId = param1.readLong();
         _totalLogs = param1.readInteger();
         _currentPage = param1.readInteger();
         _amount = param1.readInteger();
         _logs = new Vector.<WiredTransactionInfo>();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _logs.push(new WiredTransactionInfo(param1));
            _loc2_++;
         }
      }
      
      public function get logListType() : int
      {
         return _logListType;
      }
      
      public function get logListId() : int
      {
         return _logListId;
      }
      
      public function get totalLogs() : int
      {
         return _totalLogs;
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get logs() : Vector.<WiredTransactionInfo>
      {
         return _logs;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _logListType = 0;
         _logListId = 0;
         _totalLogs = 0;
         _currentPage = 0;
         _amount = 0;
         _logs = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

