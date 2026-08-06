package com.sulake.habbo.communication.messages.parser.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
   
   [SecureSWF(rename="true")]
   public class NavigatorSavedSearchesParser implements IMessageParser
   {
      private var _savedSearches:Vector.<SavedSearch>;
      
      public function NavigatorSavedSearchesParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _savedSearches = new Vector.<SavedSearch>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _savedSearches.push(new SavedSearch(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get savedSearches() : Vector.<SavedSearch>
      {
         return _savedSearches;
      }
   }
}

