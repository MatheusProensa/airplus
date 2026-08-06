package com.sulake.habbo.navigator.context
{
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class SearchContextHistoryManager
   {
      private var UnknownVarFromSearchContextHistoryManager_Vector_1:Vector.<SearchContext> = new Vector.<SearchContext>(0);
      
      private var UnknownVarFromSearchContextHistoryManager_Int_1:int = -1;
      
      public function SearchContextHistoryManager(param1:HabboNewNavigator)
      {
         super();
      }
      
      public function addSearchContextAtCurrentOffset(param1:SearchContext) : int
      {
         if(UnknownVarFromSearchContextHistoryManager_Vector_1.length > 0)
         {
            if(UnknownVarFromSearchContextHistoryManager_Vector_1[UnknownVarFromSearchContextHistoryManager_Vector_1.length - 1].toString() == param1.toString())
            {
               return UnknownVarFromSearchContextHistoryManager_Int_1;
            }
         }
         if(param1.searchCode == "popular")
         {
            UnknownVarFromSearchContextHistoryManager_Vector_1.length = 0;
            UnknownVarFromSearchContextHistoryManager_Vector_1.push(new SearchContext("hotel_view",""));
            UnknownVarFromSearchContextHistoryManager_Int_1 = 0;
         }
         if(UnknownVarFromSearchContextHistoryManager_Vector_1.length > UnknownVarFromSearchContextHistoryManager_Int_1 + 1)
         {
            UnknownVarFromSearchContextHistoryManager_Vector_1.splice(UnknownVarFromSearchContextHistoryManager_Int_1 + 1,UnknownVarFromSearchContextHistoryManager_Vector_1.length - UnknownVarFromSearchContextHistoryManager_Int_1);
         }
         UnknownVarFromSearchContextHistoryManager_Vector_1.push(param1);
         return ++UnknownVarFromSearchContextHistoryManager_Int_1;
      }
      
      public function getPreviousSearchContextAndGoBack() : SearchContext
      {
         if(hasPrevious)
         {
            UnknownVarFromSearchContextHistoryManager_Vector_1 = UnknownVarFromSearchContextHistoryManager_Vector_1.slice(-2,-1);
            UnknownVarFromSearchContextHistoryManager_Int_1 = 1;
            return UnknownVarFromSearchContextHistoryManager_Vector_1[--UnknownVarFromSearchContextHistoryManager_Int_1];
         }
         return null;
      }
      
      public function getNextSearchContextAndMoveForward() : SearchContext
      {
         if(hasNext)
         {
            return UnknownVarFromSearchContextHistoryManager_Vector_1[++UnknownVarFromSearchContextHistoryManager_Int_1];
         }
         return null;
      }
      
      public function get hasNext() : Boolean
      {
         return UnknownVarFromSearchContextHistoryManager_Int_1 + 1 < UnknownVarFromSearchContextHistoryManager_Vector_1.length;
      }
      
      public function get hasPrevious() : Boolean
      {
         return UnknownVarFromSearchContextHistoryManager_Int_1 > 0 && UnknownVarFromSearchContextHistoryManager_Vector_1.length > 0;
      }
      
      public function toString() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = "history: [";
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromSearchContextHistoryManager_Vector_1.length)
         {
            _loc2_ += UnknownVarFromSearchContextHistoryManager_Vector_1[_loc1_].toString();
            if(_loc1_ < UnknownVarFromSearchContextHistoryManager_Vector_1.length - 1)
            {
               _loc2_ = _loc2_ += ",";
            }
            _loc1_++;
         }
         return _loc2_ + "] browsing offset: " + UnknownVarFromSearchContextHistoryManager_Int_1;
      }
   }
}

