package login
{
   import com.sulake.habbo.communication.login.AvatarData;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.utils.Timer;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.ColouredButton;
   import onBoardingHcUi.LoaderUI;
   
   public class AvatarView extends Sprite
   {
      private static const avatar_halo_png:Class = avatar_halo_1_png;
      
      private static const avatar_glow_png:Class = avatar_glow_1_png;
      
      private static const placeholder_avatar:Class = placeholder_avatar_2_png;
      
      private var _context:ILoginContext;
      
      private var UnknownVarFromAvatarView_TextField_1:TextField;
      
      private var UnknownVarFromAvatarView_ColouredButton_1:ColouredButton;
      
      private var UnknownVarFromAvatarView_ColouredButton_2:ColouredButton;
      
      private var UnknownVarFromAvatarView_Boolean_1:Boolean;
      
      private var UnknownVarFromAvatarView_Vector_1:Vector.<AvatarData>;
      
      private var _spaceBetweenImages:int = 10;
      
      private var UnknownVarFromAvatarView_String_1:String;
      
      private var UnknownVarFromAvatarView_Sprite_1:Sprite;
      
      private var UnknownVarFromAvatarView_TextField_2:TextField;
      
      private var _avatarName:TextField;
      
      private var UnknownVarFromAvatarView_Int_1:int;
      
      private var _avatarImages:Vector.<DisplayObjectContainer>;
      
      private var UnknownVarFromAvatarView_Bitmap_1:Bitmap;
      
      private var _avatarGlow:Bitmap;
      
      public function AvatarView(param1:ILoginContext)
      {
         super();
         _context = param1;
         init();
         addEventListener("addedToStage",onAddedToStage);
      }
      
      public function set baseUrl(param1:String) : void
      {
         UnknownVarFromAvatarView_String_1 = param1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromAvatarView_ColouredButton_1.dispose();
         UnknownVarFromAvatarView_ColouredButton_2.dispose();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:Timer = new Timer(20,1);
         _loc2_.addEventListener("timerComplete",onAlignElements);
         _loc2_.start();
      }
      
      private function onAlignElements(param1:TimerEvent) : void
      {
         LoaderUI.lineUpVerticallyRevers(UnknownVarFromAvatarView_ColouredButton_1,20,UnknownVarFromAvatarView_Sprite_1);
         LoaderUI.alignAnchors(UnknownVarFromAvatarView_Sprite_1,0,"r",UnknownVarFromAvatarView_ColouredButton_1);
         LoaderUI.lineUpHorizontallyRevers(UnknownVarFromAvatarView_ColouredButton_1,20,UnknownVarFromAvatarView_ColouredButton_2);
         Logger.log("(avatar) Information panel: " + [UnknownVarFromAvatarView_Sprite_1.x,UnknownVarFromAvatarView_Sprite_1.y,UnknownVarFromAvatarView_Sprite_1.width,UnknownVarFromAvatarView_Sprite_1.height]);
      }
      
      public function init() : void
      {
         UnknownVarFromAvatarView_Int_1 = 0;
         if(UnknownVarFromAvatarView_Boolean_1)
         {
            return;
         }
         UnknownVarFromAvatarView_Boolean_1 = true;
         UnknownVarFromAvatarView_Sprite_1 = new Sprite();
         addChild(UnknownVarFromAvatarView_Sprite_1);
         var _loc1_:Bitmap = LoaderUI.createBalloon(640,100,0,false,995918,"none");
         UnknownVarFromAvatarView_Sprite_1.addChild(_loc1_);
         UnknownVarFromAvatarView_Sprite_1.y = 180;
         UnknownVarFromAvatarView_TextField_2 = LoaderUI.createTextField("",18,8309486,false);
         _avatarName = LoaderUI.createTextField("",20,16777215,false,true,false,false);
         _avatarName.width = 260;
         _avatarName.x = 50;
         UnknownVarFromAvatarView_TextField_2.x = 50;
         UnknownVarFromAvatarView_TextField_2.width = 260;
         UnknownVarFromAvatarView_Sprite_1.addChild(UnknownVarFromAvatarView_TextField_2);
         UnknownVarFromAvatarView_Sprite_1.addChild(_avatarName);
         LoaderUI.lineUpVertically(_loc1_,15 - _loc1_.height,_avatarName,20,UnknownVarFromAvatarView_TextField_2);
         _avatarGlow = new avatar_glow_png();
         _avatarGlow.blendMode = "add";
         _avatarGlow.visible = false;
         UnknownVarFromAvatarView_Bitmap_1 = new avatar_halo_png();
         UnknownVarFromAvatarView_Bitmap_1.blendMode = "overlay";
         UnknownVarFromAvatarView_Bitmap_1.visible = false;
         addTitleField();
         addChild(UnknownVarFromAvatarView_Bitmap_1);
         addChild(_avatarGlow);
         addButtons();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      private function addTitleField() : void
      {
         if(!UnknownVarFromAvatarView_TextField_1)
         {
            UnknownVarFromAvatarView_TextField_1 = LoaderUI.createTextField("${connection.login.account.choose}",40,16777215,false,true,false,false,"left");
            UnknownVarFromAvatarView_TextField_1.x = 0;
            UnknownVarFromAvatarView_TextField_1.y = 0;
            UnknownVarFromAvatarView_TextField_1.width = 500;
            UnknownVarFromAvatarView_TextField_1.multiline = false;
            UnknownVarFromAvatarView_TextField_1.thickness = 50;
            addChild(UnknownVarFromAvatarView_TextField_1);
         }
      }
      
      public function addButtons() : void
      {
         UnknownVarFromAvatarView_ColouredButton_2 = new ColouredButton("red","${generic.cancel}",new Rectangle(0,300,0,40),true,onCancel,14211288);
         addChild(UnknownVarFromAvatarView_ColouredButton_2);
         UnknownVarFromAvatarView_ColouredButton_1 = new ColouredButton("gfreen","${connection.login.play}",new Rectangle(0,300,0,40),true,onChooseAvatar,14211288);
         UnknownVarFromAvatarView_ColouredButton_1.active = false;
         addChild(UnknownVarFromAvatarView_ColouredButton_1);
      }
      
      public function populateAvatars(param1:Vector.<AvatarData>) : void
      {
         var _loc4_:Loader = null;
         var _loc5_:URLRequest = null;
         var _loc3_:Sprite = null;
         var _loc8_:Bitmap = null;
         var _loc2_:int = 0;
         _avatarImages = new Vector.<DisplayObjectContainer>(0);
         UnknownVarFromAvatarView_Vector_1 = param1;
         var _loc6_:int = 0;
         for each(var _loc7_ in param1)
         {
            if(_loc6_ > 6)
            {
               break;
            }
            Logger.log("Adding avatar: " + _loc7_.name);
            _loc4_ = new Loader();
            _loc4_.name = String(_loc6_);
            _loc5_ = new URLRequest(getAvatarUrl(_loc7_));
            _loc4_.load(_loc5_);
            _loc4_.contentLoaderInfo.addEventListener("complete",avatarImageLoadCompleteHandler);
            _loc4_.contentLoaderInfo.addEventListener("error",onImageError);
            _loc4_.contentLoaderInfo.addEventListener("ioError",onImageError);
            _loc4_.contentLoaderInfo.addEventListener("securityError",onImageError);
            _loc3_ = new Sprite();
            _avatarImages.push(_loc3_);
            _loc8_ = new placeholder_avatar();
            _loc3_.addChild(_loc8_);
            _loc3_.addChild(_loc4_);
            addChild(_loc3_);
            _loc3_.name = String(_loc6_);
            _loc3_.addEventListener("click",onAvatarClick);
            _loc2_ = (_loc6_ + 1) * _spaceBetweenImages + _loc6_ * 100;
            _loc3_.x = _loc2_;
            _loc3_.y = 50;
            _loc6_++;
         }
         if(param1.length > 0)
         {
            updateDescription();
            UnknownVarFromAvatarView_Int_1 = 0;
            UnknownVarFromAvatarView_ColouredButton_1.active = true;
            _avatarGlow.visible = true;
            UnknownVarFromAvatarView_Bitmap_1.visible = true;
            hilightAvatar(_avatarImages[UnknownVarFromAvatarView_Int_1]);
         }
         else
         {
            UnknownVarFromAvatarView_ColouredButton_1.active = false;
         }
      }
      
      private function onImageError(param1:ErrorEvent) : void
      {
         Logger.log("Failed to load image " + param1.text);
      }
      
      private function onAvatarClick(param1:MouseEvent) : void
      {
         UnknownVarFromAvatarView_Int_1 = int(param1.currentTarget.name);
         updateDescription();
         hilightAvatar(_avatarImages[UnknownVarFromAvatarView_Int_1]);
         UnknownVarFromAvatarView_ColouredButton_1.active = true;
      }
      
      private function avatarImageLoadCompleteHandler(param1:Event) : void
      {
         (param1.currentTarget as LoaderInfo).loader.parent.removeChildAt(0);
         _avatarGlow.visible = true;
         UnknownVarFromAvatarView_Bitmap_1.visible = true;
         hilightAvatar(_avatarImages[UnknownVarFromAvatarView_Int_1]);
      }
      
      private function updateDescription() : void
      {
         if(UnknownVarFromAvatarView_Vector_1 == null || UnknownVarFromAvatarView_Vector_1.length == 0)
         {
            return;
         }
         var _loc1_:AvatarData = UnknownVarFromAvatarView_Vector_1[UnknownVarFromAvatarView_Int_1];
         _avatarName.text = _loc1_.name;
         UnknownVarFromAvatarView_TextField_2.text = _loc1_.motto;
      }
      
      private function hilightAvatar(param1:DisplayObject) : void
      {
         var _loc2_:int = param1.x + param1.width / 2;
         var _loc3_:int = param1.y + param1.height / 2;
         _avatarGlow.x = _loc2_ - _avatarGlow.width / 2;
         _avatarGlow.y = _loc3_ - _avatarGlow.height / 2 + 15;
         UnknownVarFromAvatarView_Bitmap_1.x = _loc2_ - UnknownVarFromAvatarView_Bitmap_1.width / 2;
         UnknownVarFromAvatarView_Bitmap_1.y = _loc3_ + UnknownVarFromAvatarView_Bitmap_1.height - 40;
      }
      
      private function getAvatarUrl(param1:AvatarData) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = UnknownVarFromAvatarView_String_1 + "/habbo-imaging/avatarimage?user=" + param1.name;
         if(UnknownVarFromAvatarView_String_1.indexOf("local") > -1 || UnknownVarFromAvatarView_String_1.indexOf("127.0.0.1") > -1)
         {
            _loc3_ = "s-0.g-1.d-3.h-3.a-0";
            _loc2_ = "https://www.habbo.com/habbo-imaging/avatarimage?size=m&figure=" + param1.figure + "&direction=2";
         }
         return _loc2_;
      }
      
      private function onCancel(param1:Button) : void
      {
         _context.showScreen(2);
      }
      
      private function onChooseAvatar(param1:Button) : void
      {
         var _loc2_:int = UnknownVarFromAvatarView_Int_1;
         _context.loginWithAvatar(UnknownVarFromAvatarView_Vector_1[_loc2_]);
      }
   }
}

