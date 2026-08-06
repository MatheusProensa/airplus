package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredUserVariablesPage
   {
      private var _variableId:String = null;
      
      private var _totalEntries:int;
      
      private var _currentPage:int;
      
      private var _amount:int;
      
      private var _elements:Vector.<WiredUserVariablesElement>;
      
      private var _userTypeFilter:int;
      
      private var _sortTypFilter:int;
      
      public function WiredUserVariablesPage(param1:IMessageDataWrapper)
      {
         var _loc3_:* = undefined;
         super();
         _variableId = param1.readString();
         _totalEntries = param1.readInteger();
         _currentPage = param1.readInteger();
         _amount = param1.readInteger();
         _elements = new Vector.<WiredUserVariablesElement>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _elements.push(new WiredUserVariablesElement(param1));
            _loc3_++;
         }
         _userTypeFilter = param1.readInteger();
         _sortTypFilter = param1.readInteger();
      }
      
      public function get variableId() : String
      {
         return _variableId;
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
      
      public function get elements() : Vector.<WiredUserVariablesElement>
      {
         return _elements;
      }
      
      public function get userTypeFilter() : int
      {
         return _userTypeFilter;
      }
      
      public function get sortTypFilter() : int
      {
         return _sortTypFilter;
      }
   }
}

