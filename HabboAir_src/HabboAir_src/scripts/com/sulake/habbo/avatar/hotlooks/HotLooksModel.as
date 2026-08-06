package com.sulake.habbo.avatar.hotlooks
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.avatar.wardrobe.*;
   import com.sulake.habbo.communication.messages.outgoing.hotlooks.GetHotLooksMessageComposer;
   import com.sulake.habbo.communication.messages.parser.hotlooks.HotLookInfo;
   import com.sulake.habbo.communication.messages.parser.hotlooks.HotLooksMessageEvent;
   import flash.utils.Dictionary;
   
   public class HotLooksModel extends CategoryBaseModel implements ICategoryBaseModel_1
   {
      public static const CATEGORY_HOT_LOOKS:String = "hot_looks";
      
      public static const CATEGORY_MY_LOOKS:String = "my_looks";
      
      private static const MAXIMUM_HOT_LOOKS:int = 20;
      
      private var UnknownVarFromHotLooksModel_Dictionary_1:Dictionary;
      
      private var UnknownVarFromHotLooksModel_HotLooksMessageEvent_1:HotLooksMessageEvent;
      
      public function HotLooksModel(param1:HabboAvatarEditor)
      {
         super(param1);
         UnknownVarFromHotLooksModel_Dictionary_1 = new Dictionary();
         UnknownVarFromHotLooksModel_Dictionary_1["M"] = [];
         UnknownVarFromHotLooksModel_Dictionary_1["F"] = [];
         UnknownVarFromHotLooksModel_Dictionary_1["M.index"] = 0;
         UnknownVarFromHotLooksModel_Dictionary_1["F.index"] = 0;
         requestHotLooks(param1);
      }
      
      private function requestHotLooks(param1:HabboAvatarEditor) : void
      {
         if(param1.manager.communication)
         {
            UnknownVarFromHotLooksModel_HotLooksMessageEvent_1 = new HotLooksMessageEvent(onHotLooksMessage);
            param1.manager.communication.addHabboConnectionMessageEvent(UnknownVarFromHotLooksModel_HotLooksMessageEvent_1);
            param1.manager.communication.connection.send(new GetHotLooksMessageComposer(20));
         }
      }
      
      private function onHotLooksMessage(param1:HotLooksMessageEvent) : void
      {
         for each(var _loc2_ in param1.getParser().hotLooks)
         {
            (UnknownVarFromHotLooksModel_Dictionary_1[_loc2_.gender.toUpperCase()] as Array).push(new Outfit(_controller,_loc2_.figureString,_loc2_.gender));
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(UnknownVarFromHotLooksModel_HotLooksMessageEvent_1)
         {
            if(controller && controller.manager && controller.manager.communication)
            {
               controller.manager.communication.removeHabboConnectionMessageEvent(UnknownVarFromHotLooksModel_HotLooksMessageEvent_1);
            }
            UnknownVarFromHotLooksModel_HotLooksMessageEvent_1 = null;
         }
         UnknownVarFromHotLooksModel_Dictionary_1 = null;
      }
      
      override protected function init() : void
      {
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = new HotLooksView(this);
         }
         UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.init();
         UnknownVarFromCategoryBaseModel_Boolean_1 = true;
      }
      
      public function selectHotLook(param1:int) : void
      {
         var _loc2_:Array = UnknownVarFromHotLooksModel_Dictionary_1[_controller.gender];
         var _loc3_:Outfit = _loc2_[param1];
         if(_loc3_ != null)
         {
            if(_loc3_.figure == "")
            {
               return;
            }
            _controller.loadAvatarInEditor(_loc3_.figure,_loc3_.gender,_controller.clubMemberLevel);
         }
      }
      
      public function get hotLooks() : Array
      {
         return UnknownVarFromHotLooksModel_Dictionary_1[_controller.gender];
      }
      
      override public function switchCategory(param1:String = "") : void
      {
      }
      
      override public function getCategoryData(param1:String) : CategoryData
      {
         return null;
      }
      
      override public function selectPart(param1:String, param2:int) : void
      {
      }
   }
}

