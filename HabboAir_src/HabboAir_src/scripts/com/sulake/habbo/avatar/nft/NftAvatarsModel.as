package com.sulake.habbo.avatar.nft
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   import com.sulake.habbo.communication.messages.outgoing.nft.GetUserNftWardrobeMessageComposer;
   import com.sulake.habbo.communication.messages.parser.nft.NftWardrobeItem;
   import com.sulake.habbo.communication.messages.parser.nft.UserNftWardrobeMessageEvent;
   
   public class NftAvatarsModel extends CategoryBaseModel implements ICategoryBaseModel_1
   {
      private var _nftAvatars:Array;
      
      private var UnknownVarFromNftAvatarsModel_UserNftWardrobeMessageEvent_1:UserNftWardrobeMessageEvent;
      
      private var UnknownVarFromNftAvatarsModel_NftWardrobeParamView_1:NftWardrobeParamView;
      
      private var _selectedNftOutfit:NftOutfit;
      
      public function NftAvatarsModel(param1:HabboAvatarEditor)
      {
         super(param1);
         _nftAvatars = [];
         requestNftAvatars(param1);
      }
      
      private function requestNftAvatars(param1:HabboAvatarEditor) : void
      {
         if(param1.manager.communication)
         {
            UnknownVarFromNftAvatarsModel_UserNftWardrobeMessageEvent_1 = new UserNftWardrobeMessageEvent(onUserNftWardrobeMessage);
            param1.manager.communication.addHabboConnectionMessageEvent(UnknownVarFromNftAvatarsModel_UserNftWardrobeMessageEvent_1);
            param1.manager.communication.connection.send(new GetUserNftWardrobeMessageComposer());
         }
      }
      
      private function onUserNftWardrobeMessage(param1:UserNftWardrobeMessageEvent) : void
      {
         for each(var _loc2_ in param1.getParser().nftAvatars)
         {
            _nftAvatars.push(new NftOutfit(_controller,_loc2_.id,_loc2_.figureString,_loc2_.gender,_loc2_.tokenId,_loc2_.contractKey));
         }
      }
      
      override public function dispose() : void
      {
         if(controller && UnknownVarFromNftAvatarsModel_UserNftWardrobeMessageEvent_1)
         {
            controller.manager.communication.removeHabboConnectionMessageEvent(UnknownVarFromNftAvatarsModel_UserNftWardrobeMessageEvent_1);
            UnknownVarFromNftAvatarsModel_UserNftWardrobeMessageEvent_1 = null;
         }
         _nftAvatars = null;
         super.dispose();
      }
      
      override protected function init() : void
      {
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = new NftAvatarsView(this);
            UnknownVarFromNftAvatarsModel_NftWardrobeParamView_1 = new NftWardrobeParamView(this);
         }
         UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.init();
         UnknownVarFromCategoryBaseModel_Boolean_1 = true;
      }
      
      public function selectNftAvatar(param1:int) : void
      {
         var _loc2_:NftOutfit = _nftAvatars[param1];
         if(_loc2_ != null)
         {
            if(_loc2_.figure == "")
            {
               return;
            }
            _controller.setNftOutfit(_loc2_);
            _controller.loadAvatarInEditor(_loc2_.figure,_loc2_.gender,_controller.clubMemberLevel);
         }
         if(_selectedNftOutfit != null)
         {
            _selectedNftOutfit.view.toggleActive(false);
         }
         _selectedNftOutfit = _loc2_;
         if(_selectedNftOutfit != null)
         {
            _selectedNftOutfit.view.toggleActive(true);
         }
         UnknownVarFromNftAvatarsModel_NftWardrobeParamView_1.updateView(_loc2_);
      }
      
      public function getNftAvatarByTokenId(param1:String) : NftOutfit
      {
         var _loc3_:* = 0;
         var _loc2_:NftOutfit = null;
         _loc3_ = 0;
         while(_loc3_ < _nftAvatars.length)
         {
            _loc2_ = _nftAvatars[_loc3_];
            if(_loc2_.tokenId == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function get nftAvatars() : Array
      {
         return _nftAvatars;
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

