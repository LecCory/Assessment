import { AzureFunction, Context, HttpRequest } from '@azure/functions';
import teamService from '../services/team.service';

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
  try {
    const teamId = context.req.params.id;
    if (teamId) {
      const team = await teamService.findById(teamId);
      if (team) {
        context.res = {
          // status: 200, /* Defaults to 200 */
          body: team,
        };
      } else {
        context.res = {
          status: 404,
          body: {
            message: `Team not found with ID = ${teamId}`,
          },
        };
      }
    } else {
      const teams = await teamService.findAll();
      if (teams && teams.length > 0) {
        context.res = {
          // status: 200, /* Defaults to 200 */
          body: teams,
        };
      } else {
        context.res = {
          status: 404,
          body: {
            message: 'Team not found',
          },
        };
      }
    }
  } catch (err) {
    context.log.error(err);
    context.res = {
      status: 500,
      body: err,
    };
  }
};

export default httpTrigger;
