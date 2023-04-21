import 'package:catalago_japamix/app/modules/createEditAd/controller/create_edit_ad_controller.dart';
import 'package:catalago_japamix/base/models/establishment/establishment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/helpers/platform_type.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/dropdown_button_widget.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/picture_ad_widget.dart';
import '../../../utils/sharedWidgets/text_field_description_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';

class CreateEditAdPage extends StatefulWidget {
  final Establishment? place;

  const CreateEditAdPage({
    Key? key,
    this.place,
  }) : super(key: key);

  @override
  State<CreateEditAdPage> createState() => _CreateEditAdPageState();
}

class _CreateEditAdPageState extends State<CreateEditAdPage> {
  late CreateEditAdController controller;

  @override
  void initState() {
    controller = Get.put(CreateEditAdController(widget.place));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.backgroundFirstScreenColor,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 30.h,
                    margin: EdgeInsets.only(top: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.defaultColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.h),
                        bottomRight: Radius.circular(5.h),
                      ),
                      image: const DecorationImage(
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          Paths.backgroundImage,
                        ),
                      ),
                    ),
                  ),
                ),
                Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: AppColors.defaultColor,
                    title: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.blackColor,
                              size: 2.5.h,
                            ),
                          ),
                        ),
                        Center(
                          child: TextWidget(
                            "GUIA MIX",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    elevation: 5,
                  ),
                  backgroundColor: AppColors.transparentColor,
                  body: Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 15.h, right: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: InformationContainerWidget(
                            iconPath: Paths.iconeGuiaMixTransparente,
                            disableWhiteIconColor: true,
                            showBorder: true,
                            textColor: AppColors.blackColor,
                            backgroundColor: AppColors.defaultColor,
                            informationText: "",
                            customContainer: TextWidget(
                              "Cadastrar novo anúncio",
                              textColor: AppColors.blackColor,
                              fontSize: 18.sp,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              TextWidget(
                                "Descrição",
                                textColor: AppColors.blackColor,
                                fontSize: 18.sp,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              TextFieldDescriptionWidget(
                                focusNode: controller.descriptionFocusNode,
                                controller: controller.descriptionController,
                                hintText: "Informe a descrição do anúncio",
                                textCapitalization: TextCapitalization.sentences,
                                height: 30.h,
                                width: double.infinity,
                                maxLines: 8,
                                keyboardType: TextInputType.text,
                                enableSuggestions: true,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: (){
                                  controller.phone1FocusNode.requestFocus();
                                },
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Container(
                                color: AppColors.blackColor,
                                height: 1,
                                width: double.infinity,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              TextWidget(
                                "Telefones para contato",
                                textColor: AppColors.blackColor,
                                fontSize: 18.sp,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextFieldWidget(
                                      controller: controller.phone1TextEditingController,
                                      focusNode: controller.phone1FocusNode,
                                      hintText: "Telefone 1",
                                      textInputAction: TextInputAction.next,
                                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                      width: 45.w,
                                      keyboardType: TextInputType.phone,
                                      maskTextInputFormatter: [MasksForTextFields.cellPhoneNumberMask],
                                      hasError: controller.phone1HasError.value,
                                      validator: (String? value) {
                                        String? validation = TextFieldValidators.phoneValidation(value);
                                        controller.phone1HasError.value = validation != null && validation != "";
                                        return validation;
                                      },
                                      onEditingComplete: (){
                                        controller.phone2FocusNode.requestFocus();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            "É whatsapp?",
                                            textColor: AppColors.blackColor,
                                            fontSize: 16.sp,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Obx(
                                                () => CheckboxListTileWidget(
                                                  radioText: "Sim",
                                                  checked: controller.phoneItsWhatsapp.value,
                                                  onChanged: () {
                                                    controller.phoneItsWhatsapp.value = !controller.phoneItsWhatsapp.value;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Obx(
                                                () => CheckboxListTileWidget(
                                                  radioText: "Não",
                                                  size: 1.h,
                                                  checked: !controller.phoneItsWhatsapp.value,
                                                  onChanged: () {
                                                    controller.phoneItsWhatsapp.value = !controller.phoneItsWhatsapp.value;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFieldWidget(
                                      focusNode: controller.phone2FocusNode,
                                      controller: controller.phone2TextEditingController,
                                      hintText: "Telefone 2",
                                      textInputAction: TextInputAction.next,
                                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                      width: double.infinity,
                                      keyboardType: TextInputType.phone,
                                      maskTextInputFormatter: [MasksForTextFields.phoneNumberMask],
                                      hasError: controller.phone2HasError.value,
                                      validator: (String? value) {
                                        String? validation = TextFieldValidators.phoneValidation(value);
                                        controller.phone2HasError.value = validation != null && validation != "";
                                        return validation;
                                      },
                                      onEditingComplete: (){
                                        controller.phone3FocusNode.requestFocus();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: TextFieldWidget(
                                      focusNode: controller.phone3FocusNode,
                                      controller: controller.phone3TextEditingController,
                                      hintText: "Telefone 3 ",
                                      textInputAction: TextInputAction.next,
                                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                      width: double.infinity,
                                      keyboardType: TextInputType.phone,
                                      maskTextInputFormatter: [MasksForTextFields.phoneNumberMask],
                                      hasError: controller.phone3HasError.value,
                                      validator: (String? value) {
                                        String? validation = TextFieldValidators.phoneValidation(value);
                                        controller.phone3HasError.value = validation != null && validation != "";
                                        return validation;
                                      },
                                      onEditingComplete: (){
                                        controller.cepFocusNode.requestFocus();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                color: AppColors.blackColor,
                                height: 1,
                                width: double.infinity,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              TextWidget(
                                "Localização",
                                textColor: AppColors.blackColor,
                                fontSize: 18.sp,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: Obx(
                                  () => TextFieldWidget(
                                    controller: controller.cepTextController,
                                    focusNode: controller.cepFocusNode,
                                    hintText: "Cep",
                                    height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                    width: double.infinity,
                                    keyboardType: TextInputType.number,
                                    maskTextInputFormatter: [MasksForTextFields.cepMask],
                                    hasError: controller.cepInputHasError.value,
                                    onChanged: (value) async {
                                      if(value.length == 9){
                                        await Loading.startAndPauseLoading(
                                          () => controller.searchAddressInformation(),
                                          controller.loadingWithSuccessOrErrorWidget,
                                        );
                                      }
                                    },
                                    validator: (String? value) {
                                      String? validation = TextFieldValidators.minimumNumberValidation(value, 9, "Cep");
                                      if(validation != null && validation != ""){
                                        controller.cepInputHasError.value = true;
                                      }
                                      else{
                                        controller.cepInputHasError.value = false;
                                      }
                                      return validation;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Obx(
                                  () => SizedBox(
                                    height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: 2.w,
                                            bottom: PlatformType.isTablet(context) ? 1.7.h : 2.6.h,
                                          ),
                                          child: DropdownButtonWidget(
                                            itemSelected: controller.ufSelected.value == "" ? null : controller.ufSelected.value,
                                            hintText: "Uf",
                                            height: PlatformType.isTablet(context) ? 5.6.h : 6.5.h,
                                            width: 23.w,
                                            rxListItems: controller.ufsList,
                                            onChanged: (selectedState) {
                                              controller.ufSelected.value = selectedState ?? "";
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFieldWidget(
                                            controller: controller.cityTextController,
                                            hintText: "Cidade",
                                            textCapitalization: TextCapitalization.words,
                                            height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                            keyboardType: TextInputType.name,
                                            enableSuggestions: true,
                                            textInputAction: TextInputAction.next,
                                            hasError: controller.cityInputHasError.value,
                                            validator: (String? value) {
                                              String? validation = TextFieldValidators.standardValidation(value, "Informe a Cidade");
                                              if(validation != null && validation != ""){
                                                controller.cityInputHasError.value = true;
                                              }
                                              else{
                                                controller.cityInputHasError.value = false;
                                              }
                                              return validation;
                                            },
                                            onEditingComplete: (){
                                              controller.streetFocusNode.requestFocus();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Obx(
                                        () => TextFieldWidget(
                                          focusNode: controller.streetFocusNode,
                                          controller: controller.streetTextController,
                                          hintText: "Logradouro",
                                          textCapitalization: TextCapitalization.words,
                                          height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                          keyboardType: TextInputType.streetAddress,
                                          enableSuggestions: true,
                                          textInputAction: TextInputAction.next,
                                          hasError: controller.streetInputHasError.value,
                                          validator: (String? value) {
                                            String? validation = TextFieldValidators.standardValidation(value, "Informe o Logradouro");
                                            if(validation != null && validation != ""){
                                              controller.streetInputHasError.value = true;
                                            }
                                            else{
                                              controller.streetInputHasError.value = false;
                                            }
                                            return validation;
                                          },
                                          onEditingComplete: (){
                                            controller.houseNumberFocusNode.requestFocus();
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 2.w),
                                      child: TextFieldWidget(
                                        focusNode: controller.houseNumberFocusNode,
                                        controller: controller.houseNumberTextController,
                                        hintText: "Nº",
                                        textInputAction: TextInputAction.next,
                                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                        width: 20.w,
                                        keyboardType: TextInputType.number,
                                        onEditingComplete: (){
                                          controller.neighborhoodFocusNode.requestFocus();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Obx(
                                  () => TextFieldWidget(
                                    focusNode: controller.neighborhoodFocusNode,
                                    controller: controller.neighborhoodTextController,
                                    hintText: "Bairro",
                                    textCapitalization: TextCapitalization.words,
                                    height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                    width: double.infinity,
                                    keyboardType: TextInputType.name,
                                    enableSuggestions: true,
                                    textInputAction: TextInputAction.next,
                                    hasError: controller.neighborhoodInputHasError.value,
                                    validator: (String? value) {
                                      String? validation = TextFieldValidators.standardValidation(value, "Informe o Bairro");
                                      if(validation != null && validation != ""){
                                        controller.neighborhoodInputHasError.value = true;
                                      }
                                      else{
                                        controller.neighborhoodInputHasError.value = false;
                                      }
                                      return validation;
                                    },
                                    onEditingComplete: (){
                                      controller.complementFocusNode.requestFocus();
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: TextFieldWidget(
                                  focusNode: controller.complementFocusNode,
                                  controller: controller.complementTextController,
                                  hintText: "Complemento",
                                  textCapitalization: TextCapitalization.sentences,
                                  height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                  width: double.infinity,
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: true,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                color: AppColors.blackColor,
                                height: 1,
                                width: double.infinity,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              TextWidget(
                                "Fotos",
                                textColor: AppColors.blackColor,
                                fontSize: 18.sp,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 2.h),
                                child: SizedBox(
                                  height: 20.h,
                                  child: Obx(
                                    () => ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      children: [
                                        InkWell(
                                          onTap: () async => await controller.addNewPicture(),
                                          child: Container(
                                            width: 50.w,
                                            padding: EdgeInsets.all(1.h),
                                            margin: EdgeInsets.only(right: 2.w),
                                            decoration: BoxDecoration(
                                              color: AppColors.grayBackgroundPictureColor,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                color: AppColors.blackColor,
                                                width: .25.h,
                                              ),
                                            ),
                                            child: Image.asset(
                                              Paths.adicionarImagem,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        if(controller.placeImages.isNotEmpty)
                                          ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller.placeImages.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () => ViewPicture.openPicture(
                                                  controller.placeImages[index].path
                                                ),
                                                onLongPress: () async => await controller.removePicture(index),
                                                child: PictureAdWidget(
                                                  path: controller.placeImages[index].path,
                                                ),
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                controller.loadingWithSuccessOrErrorWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
