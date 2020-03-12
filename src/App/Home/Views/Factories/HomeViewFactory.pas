(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit HomeViewFactory;

interface

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view TUploadView
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    THomeViewFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils,


    {*! -------------------------------
        unit interfaces
    ----------------------------------- *}
    HomeView;

    function THomeViewFactory.build(const container : IDependencyContainer) : IDependency;
    var fReader : IFileReader;
        templateFile : string;
    begin
        fReader := TStringFileReader.create();
        templateFile := getCurrentDir() + '/resources/Templates/home.html';
        result := THomeView.create(fReader.readFile(templateFile));
    end;
end.
