package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.roomlogs
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredLogPage
   {
      private var _totalEntries:int;
      
      private var _currentPage:int;
      
      private var _amount:int;
      
      private var _elements:Vector.<WiredLogEntry>;
      
      private var _logLevelFilter:int;
      
      private var _logSourceFilter:int;
      
      private var _query:String;
      
      public function WiredLogPage(param1:IMessageDataWrapper)
      {
         var _loc3_:* = undefined;
         super();
         _totalEntries = param1.readInteger();
         _currentPage = param1.readInteger();
         _amount = param1.readInteger();
         _elements = new Vector.<WiredLogEntry>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _elements.push(new WiredLogEntry(param1));
            _loc3_++;
         }
         _logLevelFilter = -1;
         _logSourceFilter = -1;
         _query = null;
         if(param1.readBoolean())
         {
            _logLevelFilter = param1.readByte();
         }
         if(param1.readBoolean())
         {
            _logSourceFilter = param1.readByte();
         }
         if(param1.readBoolean())
         {
            _query = param1.readString();
         }
      }
      
      public function get totalEntries() : int
      {
         return _totalEntries;
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get elements() : Vector.<WiredLogEntry>
      {
         return _elements;
      }
      
      public function get logLevelFilter() : int
      {
         return _logLevelFilter;
      }
      
      public function get logSourceFilter() : int
      {
         return _logSourceFilter;
      }
      
      public function get query() : String
      {
         return _query;
      }
   }
}

