
(*!------------------------------------------------------------
 * Fano Web Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-middleware
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-middleware/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit UploadValidatorFactory;

interface

uses
    fano;

type

    TUploadValidatorFactory = class(TFactory, IDependencyFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses
    sysutils;

    function TUploadValidatorFactory.build(const container : IDependencyContainer) : IDependency;
    begin
        result := (TValidation.create(THashList.create()))
            .addRule(
                'username',
                //TCompositeValidator.create([
                    //TNotValidator.create('Not required', TRequiredValidator.create()),
                    //TAlphaNumSpaceValidator.create(TRegex.create())
                //])
                TAlphaNumSpaceValidator.create(TRegex.create())
            ).addRule(
                'imageData',
                //file uploaded is required and must be valid uploaded file with
                //size not exceed 500Kb with format JPEG or PNG only and free from
                //computer virus
                TCompositeValidator.create([
                    TRequiredValidator.create(),
                    TUploadedFileValidator.create(),
                    TUploadedSizeValidator.create(500 * 1024),
                    TUploadedMimeValidator.create(['image/jpg', 'image/jpeg', 'image/png']),
                    TAnyOfValidator.create([
                        TImagePngValidator.create(),
                        TImageJpgValidator.create()
                    ]),
                    //TAntivirusValidator.create(TNullAv.create()),
                    TAntivirusValidator.create(TLocalClamdAv.create('/var/run/clamav/clamd.ctl'))
                ])
            ) as IDependency;
    end;
end.
