package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class PetInventoryMessageParser implements IMessageParser
   {
      protected var _totalFragments:int;
      
      protected var _fragmentNo:int;
      
      private var _petListFragment:Map;
      
      public function PetInventoryMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_petListFragment)
         {
            _petListFragment.dispose();
            _petListFragment = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:PetData = null;
         _totalFragments = param1.readInteger();
         _fragmentNo = param1.readInteger();
         _petListFragment = new Map();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new PetData(param1);
            _petListFragment.add(_loc4_.id,_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function get petListFragment() : Map
      {
         return _petListFragment;
      }
      
      public function get totalFragments() : int
      {
         return _totalFragments;
      }
      
      public function get fragmentNo() : int
      {
         return _fragmentNo;
      }
   }
}

