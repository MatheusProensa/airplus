package com.sulake.habbo.catalog.recycler
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class RecycleRewardDisplayWrapper implements IProductDisplayInfo
   {
      private var UnknownVarFromRecycleRewardDisplayWrapper_String_1:String;
      
      private var UnknownVarFromRecycleRewardDisplayWrapper_Int_1:int;
      
      public function RecycleRewardDisplayWrapper(param1:String, param2:int)
      {
         super();
         UnknownVarFromRecycleRewardDisplayWrapper_String_1 = param1;
         UnknownVarFromRecycleRewardDisplayWrapper_Int_1 = param2;
      }
      
      public function get productTypeId() : int
      {
         switch(UnknownVarFromRecycleRewardDisplayWrapper_String_1)
         {
            case "chat_style":
               return 9;
            case "i":
               return 0;
            case "s":
               return 1;
            default:
               return -1;
         }
      }
      
      public function get itemTypeId() : String
      {
         return String(UnknownVarFromRecycleRewardDisplayWrapper_Int_1);
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get botFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return undefined;
      }
      
      public function get extraData() : String
      {
         return "";
      }
   }
}

