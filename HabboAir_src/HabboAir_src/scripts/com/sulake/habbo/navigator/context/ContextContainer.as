package com.sulake.habbo.navigator.context
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.TopLevelContext;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorMetaDataParser;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class ContextContainer
   {
      private var _navigator:HabboNewNavigator;
      
      private var UnknownVarFromContextContainer_Map_1:Map;
      
      private var _savedSearches:Vector.<SavedSearch> = new Vector.<SavedSearch>();
      
      public function ContextContainer(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function hasContextFor(param1:String) : Boolean
      {
         if(!UnknownVarFromContextContainer_Map_1)
         {
            return false;
         }
         return UnknownVarFromContextContainer_Map_1.hasKey(param1);
      }
      
      public function initialize(param1:NavigatorMetaDataParser) : void
      {
         UnknownVarFromContextContainer_Map_1 = new Map();
         for each(var _loc2_ in param1.topLevelContexts)
         {
            UnknownVarFromContextContainer_Map_1.add(_loc2_.searchCode,_loc2_.quickLinks);
         }
      }
      
      public function getTopLevelSearches() : Array
      {
         return UnknownVarFromContextContainer_Map_1.getKeys();
      }
      
      public function get savedSearches() : Vector.<SavedSearch>
      {
         return _savedSearches;
      }
      
      public function set savedSearches(param1:Vector.<SavedSearch>) : void
      {
         _savedSearches = param1;
      }
      
      public function isReady() : Boolean
      {
         return UnknownVarFromContextContainer_Map_1 != null;
      }
   }
}

